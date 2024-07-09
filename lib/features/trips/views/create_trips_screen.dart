import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trippify/features/home/views/home_screen.dart';
import 'package:trippify/features/trips/view_models/trip.viewmodel.dart';
import 'package:trippify/utils/colors.dart';
import 'package:trippify/utils/spacing.dart';
import 'package:trippify/utils/styles.dart';
import '../../shared/helpers/shared_preferences_manager.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final tripNameController = TextEditingController();
  final tripStartPointController = TextEditingController();
  final tripEndPointController = TextEditingController();

  // trip values
  DateTime? startDate;
  DateTime? endDate;
  String? formattedStartDate;
  String? formattedEndDate;

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
                style: AppStyles.tsFS50CPW600,
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
                    label: 'Trip Start time',
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
                    label: 'Trip End time',
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
              Consumer<TripViewmodel>(builder: (context, tripViewmodel, child) {
                return GestureDetector(
                  onTap: tripViewmodel.selectImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: tripViewmodel.selectedImage != null
                          ? Image.file(
                              tripViewmodel.selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.add_photo_alternate),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 40, top: 20),
        child:
            Consumer<TripViewmodel>(builder: (context, tripViewmodel, child) {
          return tripViewmodel.isLoading
              ? const LoadingWidget()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      tripViewmodel.tripName = tripNameController.text;
                      tripViewmodel.tripStartPoint = tripNameController.text;
                      tripViewmodel.tripStartTime = tripNameController.text;
                      tripViewmodel.tripEndPoint = tripNameController.text;
                      tripViewmodel.tripName = tripNameController.text;
                      tripViewmodel.selectedImage = tripViewmodel.selectedImage;
                      return await tripViewmodel.createTrip(context);
                    },
                    child: const Text('Create Trip'),
                  ),
                );
        }),
      ),
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget({
    super.key,
    required this.label,
    required this.dateTime,
    required this.onTap,
  });

  String? dateTime;
  String label;
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
          Text(widget.label),
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
