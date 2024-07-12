import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trippify/utils/constants.dart';
import 'package:trippify/utils/spacing.dart';
import '../../../shared/helpers/shared_preferences_manager.dart';
import '../../../utils/colors.dart';
import '../../../utils/strings.dart';
import '../../../utils/styles.dart';

class TripItemWidget extends StatelessWidget {
  TripItemWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.startLocation,
    required this.description,
    required this.docId,
    required this.isYourJob,
    this.hasJoined = false,
  });

  final String? imageUrl;
  final String? name;
  final String? docId;
  final String? startLocation;
  final String? description;
  bool isYourJob;
  bool hasJoined;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            color: colorFFFFFFFF,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 20, // Increased blur radius
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(6.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image(
                      image:
                          NetworkImage(imageUrl ?? AppConstants.dummyTripImage),
                      fit: BoxFit.cover,
                      height: 200.h,
                      width: 1.sw,
                    ),
                  ),
                  Positioned(
                    right: 5.w,
                    top: 5.h,
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: colorFFFFFFFF,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                          color: colorFFFFFFFF,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Row(
                        children: [
                          Text(
                            'Coming Soon',
                            style: AppStyles.tsFS12C00W600,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gv20,
                    SizedBox(
                      width: 1.sw,
                      child: Text(
                        name ?? AppStrings.loadingText,
                        style: AppStyles.tsFS20C00W400,
                      ),
                    ),
                    gv05,
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              size: 18,
                              color: borderColor,
                            ),
                            gv10,
                            SizedBox(
                              width: 165.w,
                              child: Text(
                                startLocation ?? AppStrings.loadingText,
                                style: AppStyles.tsFS14CGreyW400,
                              ),
                            ),
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
                    gv10,
                    Text(
                      description ?? AppStrings.loadingText,
                      style: AppStyles.tsFS12C00W600,
                    ),
                    gv20,
                  ],
                ),
              ),
            ],
          ),
        ),
        gv10,
      ],
    );
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
