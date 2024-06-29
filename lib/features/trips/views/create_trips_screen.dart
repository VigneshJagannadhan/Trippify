import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippify/features/home/home_screen.dart';
import 'package:trippify/features/maps/map_screen.dart';
import 'package:trippify/utils/colors.dart';
import 'package:trippify/utils/sp_keys.dart';
import 'package:trippify/utils/spacing.dart';
import 'package:trippify/utils/styles.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final tripNameController = TextEditingController();
  final tripStartPointController = TextEditingController();
  final tripEndPointController = TextEditingController();
  String imageUrl = '';
  XFile? image;
  File? selectedImage;

  // trip values
  DateTime? startDate;
  DateTime? endDate;
  String? formattedStartDate;
  String? formattedEndDate;

  selectImage() async {
    final imagePicker = ImagePicker();
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await imagePicker.pickImage(source: ImageSource.gallery);
      selectedImage = File(image!.path);
      setState(() {});
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;

    if (selectedImage != null) {
      //Upload to Firebase
      var snapshot = await firebaseStorage
          .ref('images/trips/${image?.name}')
          .putFile(selectedImage!);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload to Firebase storage failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFFFF,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gv50,
              Text(
                'Create your trip',
                style: AppStyles.tsFS50CPW600shadowsIntoLight,
              ),
              gv50,
              const Text('Trip name'),
              gv10,
              TextFormField(
                controller: tripNameController,
              ),
              gv20,
              Row(
                children: [
                  DatePickerWidget(
                    dateTime: formattedStartDate,
                    onTap: () async {
                      startDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      formattedStartDate =
                          DateFormat('dd/MM/yyyy').format(startDate!);
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DatePickerWidget(
                    dateTime: formattedEndDate,
                    onTap: () async {
                      endDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      formattedEndDate =
                          DateFormat('dd/MM/yyyy').format(endDate!);
                      setState(() {});
                    },
                  ),
                ],
              ),
              gv20,
              const Text('Starting point'),
              gv10,
              TextFormField(
                controller: tripStartPointController,
              ),
              gv20,
              const Text('Destination'),
              gv10,
              TextFormField(
                controller: tripEndPointController,
              ),
              gv20,
              const Text('Pick an image'),
              gv10,
              GestureDetector(
                onTap: selectImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: selectedImage != null
                        ? Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.add_photo_alternate),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 40, top: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: ElevatedButton(
            onPressed: () async => await create_trip(context),
            child: const Text('Create Trip'),
          ),
        ),
      ),
    );
  }

  Future<void> create_trip(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString(sp_user_id);
    String? chatId;
    final db = FirebaseFirestore.instance;
    await uploadImage();
    final trip = <String, dynamic>{
      "user_id": userId,
      "trip_name": tripNameController.text,
      "trip_start": tripStartPointController.text,
      "trip_end": tripEndPointController.text,
      "trip_start_time": startDate.toString(),
      "trip_end_time": endDate.toString(),
      "image_url": imageUrl,
      "created_date": DateTime.now().toString(),
      "joined_users": [userId],
    };

    /// create a trip in the 'trips' collection
    db.collection("trips").add(trip).then((DocumentReference doc) async {
      chatId = doc.id;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your trip has been created!')));

      final chat = <String, dynamic>{
        "chat_id": chatId,
        "trip_name": tripNameController.text,
        "image_url": imageUrl,
        "created_date": DateTime.now().toString(),
        "joined_users": [userId],
      };

      DocumentReference docRef =
          FirebaseFirestore.instance.collection('chat').doc(chatId);
      await docRef.set(chat);
    });
  }
}

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget({super.key, required this.dateTime, required this.onTap});

  String? dateTime;
  Function()? onTap;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trip End time'),
          gv10,
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorFFFFFFFF,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.2),
              ),
              child: Text((widget.dateTime ?? '').toString()),
            ),
          ),
        ],
      ),
    );
  }
}
