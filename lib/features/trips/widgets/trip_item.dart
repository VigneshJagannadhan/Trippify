import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippify/utils/sp_keys.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';

class TripItemWidget extends StatelessWidget {
  TripItemWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.description,
    required this.docId,
    required this.isYourJob,
    this.hasJoined = false,
  });

  final String imageUrl;
  final String name;
  final String? docId;
  final String location;
  final String description;
  bool isYourJob;
  bool hasJoined;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: colorFFFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: colorFFFFFFFF,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // isYourJob
                  //     ? const SizedBox()
                  //     : Positioned(
                  //         top: 10,
                  //         right: 10,
                  //         child: GestureDetector(
                  //           onTap: () async {
                  //             isFavourite = !isFavourite;
                  //             DocumentReference<Map<String, dynamic>> doc =
                  //                 FirebaseFirestore.instance
                  //                     .collection('trips')
                  //                     .doc(docId);

                  //             await doc.update({"isFavourite": isFavourite});
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 25,
                  //             backgroundColor: Colors.grey.withOpacity(0.5),
                  //             child: Icon(
                  //               isFavourite
                  //                   ? Icons.favorite
                  //                   : Icons.favorite_border,
                  //               color: isFavourite
                  //                   ? Colors.redAccent
                  //                   : colorFFFFFFFF,
                  //               size: 30,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          name,
                          style: AppStyles.tsFS23C00W400,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              size: 18,
                              color: borderColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                location,
                                style: AppStyles.tsFS16CGreyW400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          description,
                          style: AppStyles.tsFS12C00W600,
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: hasJoined
                            ? ElevatedButton.styleFrom(
                                backgroundColor: Colors.red)
                            : ElevatedButton.styleFrom(),
                        onPressed: () async {
                          if (isYourJob) {
                            // handle edit trip here
                          } else {
                            // handle join trip here
                            await joinOrExitTrip();
                          }
                        },
                        child: Text(
                          isYourJob
                              ? 'Edit Trip'
                              : (hasJoined ? 'Exit Trip' : 'Join Trip'),
                          style: AppStyles.tsFS16CFFW600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> joinOrExitTrip() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString(sp_user_id);
    DocumentReference tripRef =
        FirebaseFirestore.instance.collection('trips').doc(docId);
    DocumentReference chatRef =
        FirebaseFirestore.instance.collection('chat').doc(docId);
    hasJoined = !hasJoined;
    if (hasJoined) {
      await tripRef.update({
        'joined_users': FieldValue.arrayUnion([userId]),
      });
      await chatRef.update({
        'joined_users': FieldValue.arrayUnion([userId]),
      });
    } else {
      await tripRef.update({
        'joined_users': FieldValue.arrayRemove([userId]),
      });
      await chatRef.update({
        'joined_users': FieldValue.arrayRemove([userId]),
      });
    }
  }
}
