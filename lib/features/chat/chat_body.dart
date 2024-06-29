import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  ChatBody({super.key, this.userId, required this.stream});

  Stream<QuerySnapshot<Object?>>? stream;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(snapshot.data?.docs[index]['trip_name']),
          ),
        );
      },
    );
  }
}
