import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trippify/utils/spacing.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../shared/helpers/shared_preferences_manager.dart';

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
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: colorFFFFFFFF,
                      borderRadius: BorderRadius.circular(30.r),
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
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gv20,
                        Text(
                          name,
                          style: AppStyles.tsFS20C00W400,
                        ),
                        gv05,
                        Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              size: 18,
                              color: borderColor,
                            ),
                            gv10,
                            SizedBox(
                              width: 170.w,
                              child: Text(
                                location,
                                style: AppStyles.tsFS14CGreyW400,
                              ),
                            ),
                          ],
                        ),
                        gv10,
                        Text(
                          description,
                          style: AppStyles.tsFS12C00W600,
                        ),
                        gv20,
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
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
                          style: AppStyles.tsFS14CFFW600,
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
    String? userId = SharedPreferencesManager.getUserId();
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
