import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippify/features/trips/widgets/trip_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyTripsBody extends StatelessWidget {
  MyTripsBody({
    super.key,
    required this.userId,
    required this.stream,
  });

  final String userId;
  Stream<QuerySnapshot<Object?>>? stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) => TripItemWidget(
              imageUrl: snapshot.data?.docs[index]['image_url'],
              name: snapshot.data?.docs[index]['trip_name'],
              location: snapshot.data?.docs[index]['trip_start'],
              description: snapshot.data?.docs[index]['created_date'],
              docId: snapshot.data?.docs[index].id,
              // isFavourite: snapshot.data?.docs[index]['isFavourite'],
              isYourJob: snapshot.data?.docs[index]['user_id'] == userId,
            ),
          ),
        );
      },
    );
  }
}
