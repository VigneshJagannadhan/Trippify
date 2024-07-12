import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trippify/features/trips/views/create_trips_screen.dart';
import 'package:trippify/shared/helpers/shared_preferences_manager.dart';

import '../../../shared/widgets/empty_list_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/spacing.dart';
import '../../../utils/strings.dart';
import '../../../utils/styles.dart';
import '../widgets/trip_item.dart';

class MyTripsBody extends StatelessWidget {
  MyTripsBody({
    super.key,
    required this.stream,
  });

  Stream<QuerySnapshot<Object?>>? stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        String? userId = SharedPreferencesManager.getUserId();
        if (!snapshot.hasData) return const Text('Loading...');
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gv70,
                    Text(
                      'My Trips',
                      style: AppStyles.tsFS24C00W400,
                    ),
                    gv20,
                    (snapshot.data?.docs.isEmpty ?? true)
                        ? EmptyListWidget(
                            lottieAsset: AppConstants.nothingToSeeHereLottie,
                            emptyListText: AppStrings.noTripsCreatedText,
                          )
                        : Column(
                            children: List.generate(
                              snapshot.data?.docs.length ?? 0,
                              (index) => TripItemWidget(
                                imageUrl: snapshot.data?.docs[index]
                                    ['image_url'],
                                name: snapshot.data?.docs[index]['trip_name'],
                                startLocation: snapshot.data?.docs[index]
                                    ['trip_start'],
                                description: snapshot.data?.docs[index]
                                    ['created_date'],
                                docId: snapshot.data?.docs[index].id,
                                // isFavourite: snapshot.data?.docs[index]['isFavourite'],
                                isYourJob: snapshot.data?.docs[index]
                                        ['user_id'] ==
                                    userId,
                              ),
                            ),
                          )
                    // ListView.builder(
                    //   itemCount: snapshot.data?.docs.length,
                    //   itemBuilder: (context, index) => TripItemWidget(
                    //     imageUrl: snapshot.data?.docs[index]['image_url'],
                    //     name: snapshot.data?.docs[index]['trip_name'],
                    //     location: snapshot.data?.docs[index]['trip_start'],
                    //     description: snapshot.data?.docs[index]['created_date'],
                    //     docId: snapshot.data?.docs[index].id,
                    //     // isFavourite: snapshot.data?.docs[index]['isFavourite'],
                    //     isYourJob: snapshot.data?.docs[index]['user_id'] == userId,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30.h,
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
            ),
          ],
        );
      },
    );
  }
}
