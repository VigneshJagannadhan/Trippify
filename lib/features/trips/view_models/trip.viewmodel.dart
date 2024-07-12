import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared/helpers/shared_preferences_manager.dart';
import '../../../shared/view_models/loading.viewmodel.dart';
import '../models/trip_model.dart';
import '../repository/trip_repo.dart';

class TripViewmodel extends LoadingViewModel {
  TripViewmodel({required this.repo});

  final TripRepo repo;

  String? _tripName;
  String? get tripName => _tripName;
  set tripName(tripName) {
    _tripName = tripName;
    notifyListeners();
  }

  String? _tripStartPoint;
  String? get tripStartPoint => _tripStartPoint;
  set tripStartPoint(tripStartPoint) {
    _tripStartPoint = tripStartPoint;
    notifyListeners();
  }

  String? _tripStartTime;
  String? get tripStartTime => _tripStartTime;
  set tripStartTime(tripStartTime) {
    _tripStartTime = tripStartTime;
    notifyListeners();
  }

  String? _tripEndPoint;
  String? get tripEndPoint => _tripEndPoint;
  set tripEndPoint(tripEndPoint) {
    _tripEndPoint = tripEndPoint;
    notifyListeners();
  }

  String? _tripEndTime;
  String? get tripEndTime => _tripEndTime;
  set tripEndTime(tripEndTime) {
    _tripEndTime = tripEndTime;
    notifyListeners();
  }

  XFile? _image;
  XFile? get image => _image;
  set image(image) {
    _image = image;
    notifyListeners();
  }

  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  set imageUrl(imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  set selectedImage(selectedImage) {
    _selectedImage = selectedImage;
    notifyListeners();
  }

  Future<XFile?> selectImage() async {
    final imagePicker = ImagePicker();
    if (await Permission.storage.request().isGranted) {
      //Select Image
      image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image!.path);
      }
    } else {
      log('Permission not granted. Try Again with permission access');
      await Permission.storage.request();
    }

    return image;
  }

  uploadImage(context) async {
    try {
      imageUrl = await repo.uploadImage(
          context: context, selectedImage: selectedImage, image: image);
    } catch (e) {
      log(e.toString());
    }
  }

  createTrip(BuildContext context) async {
    isLoading = true;

    // Get the user Id from SharedPrefs
    String? userId = SharedPreferencesManager.getUserId();

    // upload image to firebase storage and return the url
    final imageUrl = await repo.uploadImage(
        context: context, selectedImage: selectedImage, image: image);

    // Create a trip model
    TripModel tripModel = TripModel(
      DateTime.now().toString(),
      imageUrl,
      [userId ?? ''],
      tripEndPoint,
      tripEndTime,
      tripStartPoint,
      tripStartTime,
      tripName,
      userId,
    );

    //creating the trip
    try {
      isLoading = true;
      await repo.createTrip(
        context: context,
        tripModel: tripModel,
        selectedImage: selectedImage,
        image: image,
      );
    } catch (e) {
      log('error in fetch_data : ${e.toString()}');
    }
    isLoading = false;
  }
}
