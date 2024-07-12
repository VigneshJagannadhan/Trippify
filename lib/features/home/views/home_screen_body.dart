import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trippify/utils/spacing.dart';
import '../../../shared/widgets/empty_list_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import '../../../utils/styles.dart';
import '../widgets/home_body_loading.dart';
import '../widgets/trips_list_view_widget.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    super.key,
    required this.stream,
  });

  Stream<QuerySnapshot<Object?>>? stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        var docs = snapshot.data?.docs;
        if (!snapshot.hasData) return const LoadingWidget();
        return SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Join a trip Text Widget
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gv70,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundImage:
                                  AssetImage(AppConstants.dummyPersonImage),
                            ),
                            gh10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Morning,',
                                  style: AppStyles.tsFS12CGrey600W600,
                                ),
                                Text(
                                  'Vignesh Jagannadhan',
                                  style: AppStyles.tsFS16C00W400,
                                ),
                              ],
                            ),
                          ],
                        ),
                        gv30,
                        Text(
                          AppStrings.joinTripText,
                          style: AppStyles.tsFS24C00W400,
                        ),
                        gv20,
                      ],
                    ),
                  ),

                  /// Trips List Builder and Empty Jobs List builder
                  (snapshot.data?.docs.isEmpty ?? true)
                      ? EmptyListWidget(
                          lottieAsset: AppConstants.nothingToSeeHereLottie,
                          emptyListText: AppStrings.noTripsToJoinText,
                        )
                      : TripsListViewWidget(
                          docs: docs,
                        )
                ],
              )),
        );
      },
    );
  }
}
