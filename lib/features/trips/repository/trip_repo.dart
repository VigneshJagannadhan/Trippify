import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../home/model/trip_model.dart';

abstract class TripRepo {
  Future<void> createTrip({
    required BuildContext context,
    required TripModel tripModel,
    required File? selectedImage,
    required XFile? image,
  });
  Future<String> uploadImage({
    required BuildContext context,
    required File? selectedImage,
    required XFile? image,
  });
}

class TripRepoImpl extends TripRepo {
  @override
  uploadImage({
    required BuildContext context,
    required File? selectedImage,
    required XFile? image,
  }) async {
    final firebaseStorage = FirebaseStorage.instance;
    String imageUrl = '';
    if (selectedImage != null) {
      //Upload to Firebase
      var snapshot = await firebaseStorage
          .ref('images/trips/${image?.name}')
          .putFile(selectedImage);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload to Firebase storage failed')));
    }

    return imageUrl;
  }

  @override
  Future<void> createTrip({
    required BuildContext context,
    required TripModel tripModel,
    required File? selectedImage,
    required XFile? image,
  }) async {
    final db = FirebaseFirestore.instance;
    final tripObject = TripModel(
      tripModel.createdDate,
      tripModel.imageUrl,
      tripModel.joinedUsers,
      tripModel.tripEnd,
      tripModel.tripEndTime,
      tripModel.tripStart,
      tripModel.tripStartTime,
      tripModel.tripName,
      tripModel.userId,
    );

    /// create a trip in the 'trips' collection
    db
        .collection("trips")
        .add(tripObject.toJson())
        .then((DocumentReference doc) async {
      String chatId = doc.id;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your trip has been created!')));

      final chat = <String, dynamic>{
        "chat_id": chatId,
        "trip_name": tripModel.tripName,
        "image_url": tripModel.imageUrl,
        "created_date": tripModel.createdDate,
        "joined_users": [tripModel.userId],
      };

      DocumentReference docRef =
          FirebaseFirestore.instance.collection('chat').doc(chatId);
      await docRef.set(chat);
    });
  }
}
