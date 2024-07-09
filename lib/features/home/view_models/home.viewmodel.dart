import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trippify/features/home/repository/home_repo.dart';
import 'package:trippify/features/shared/view_models/loading.viewmodel.dart';

class HomeViewModel extends LoadingViewModel {
  HomeViewModel({
    required this.repo,
  });

  final HomeRepo repo;

  Stream<QuerySnapshot<Object?>>? _allTripsModel;
  Stream<QuerySnapshot<Object?>>? _myTripsModel;
  Stream<QuerySnapshot<Object?>>? _myChatModel;

  Stream<QuerySnapshot<Object?>>? get allTripsModel => _allTripsModel;
  Stream<QuerySnapshot<Object?>>? get myTripsModel => _myTripsModel;
  Stream<QuerySnapshot<Object?>>? get myChatModel => _myChatModel;

  set allTripsModel(allTripsModel) {
    _allTripsModel = allTripsModel;
    notifyListeners();
  }

  set myTripsModel(myTripsModel) {
    _myTripsModel = myTripsModel;
    notifyListeners();
  }

  set myChatModel(myChatModel) {
    _myChatModel = myChatModel;
    notifyListeners();
  }

  fetchAllTrips() async {
    try {
      isLoading = true;
      _allTripsModel = await repo.fetchAllTrips();
    } catch (e) {
      log('error in fetch_data : ${e.toString()}');
    }
    isLoading = false;
  }

  fetchMyChats() async {
    try {
      isLoading = true;
      _myChatModel = await repo.fetchMyChats();
    } catch (e) {
      log('error in fetch_data : ${e.toString()}');
    }
    isLoading = false;
  }

  fetchMyTrips() async {
    try {
      isLoading = true;
      _myTripsModel = await repo.fetchMyTrips();
    } catch (e) {
      log('error in fetch_data : ${e.toString()}');
    }
    isLoading = false;
  }
}
