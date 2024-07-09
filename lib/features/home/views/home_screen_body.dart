import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trippify/features/trips/views/create_trips_screen.dart';
import 'package:trippify/features/trips/widgets/trip_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    super.key,
    required this.stream,
    required this.userId,
  });

  Stream<QuerySnapshot<Object?>>? stream;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return TripItemWidget(
                    imageUrl: snapshot.data?.docs[index]['image_url'],
                    name: snapshot.data?.docs[index]['trip_name'],
                    location: snapshot.data?.docs[index]['trip_start'],
                    description: snapshot.data?.docs[index]['created_date'],
                    docId: snapshot.data?.docs[index].id,
                    // isFavourite: snapshot.data?.docs[index]['isFavourite'],
                    isYourJob: snapshot.data?.docs[index]['user_id'] == userId,
                    hasJoined:
                        (snapshot.data?.docs[index]['joined_users'] as List)
                            .contains(userId),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10.h,
              right: 20.w,
              child: SizedBox(
                width: 190.w,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateTripScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Create Trip',
                        style: AppStyles.tsFS14CFFW600,
                      ),
                      SvgPicture.asset(
                        AppConstants.createTripSvg,
                        width: 50.w,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
