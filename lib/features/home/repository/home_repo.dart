import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/helpers/shared_preferences_manager.dart';

abstract class HomeRepo {
  Future<Stream<QuerySnapshot<Object?>>> fetchAllTrips();
  Future<Stream<QuerySnapshot<Object?>>> fetchMyChats();
  Future<Stream<QuerySnapshot<Object?>>> fetchMyTrips();
}

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Stream<QuerySnapshot<Object?>>> fetchAllTrips() async {
    String? userId = SharedPreferencesManager.getUserId();

    Stream<QuerySnapshot<Object?>> allTripsStream = FirebaseFirestore.instance
        .collection('trips')
        .where('user_id', isNotEqualTo: userId)
        .snapshots();
    return allTripsStream;
  }

  @override
  Future<Stream<QuerySnapshot<Object?>>> fetchMyChats() async {
    String? userId = SharedPreferencesManager.getUserId();

    Stream<QuerySnapshot<Object?>> chatsStream = FirebaseFirestore.instance
        .collection('chat')
        .where('joined_users', arrayContains: userId)
        .snapshots();
    return chatsStream;
  }

  @override
  Future<Stream<QuerySnapshot<Object?>>> fetchMyTrips() async {
    String? userId = SharedPreferencesManager.getUserId();
    Stream<QuerySnapshot<Object?>> myTripsStream = FirebaseFirestore.instance
        .collection('trips')
        .where('user_id', isEqualTo: userId)
        .snapshots();
    return myTripsStream;
  }
}
