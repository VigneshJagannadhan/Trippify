import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trippify/shared/helpers/shared_preferences_manager.dart';
import 'package:trippify/utils/constants.dart';

import '../../../utils/strings.dart';
import '../../trips/models/trip_model.dart';
import '../../trips/widgets/trip_item.dart';

class TripsListViewWidget extends StatelessWidget {
  const TripsListViewWidget({
    super.key,
    required this.docs,
  });

  final List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(docs?.length ?? 0, (index) {
        /// Creating a trip object
        TripModel tripObject = TripModel.fromJson(docs?[index].data() as Map);

        /// Formatting the start date
        String formattedStartDate = DateFormat(AppConstants.dateFormatDateTime)
            .format(DateTime.parse(
                tripObject.tripEndTime ?? DateTime.now().toString()));

        String? userId = SharedPreferencesManager.getUserId();

        // String formattedStartDate = AppStrings.loadingText;

        /// Checking if the current user has already joined this trip
        bool hasJoined = (tripObject.joinedUsers as List).contains(userId);

        /// Checking if this job belongs to the current user
        bool isYourJob = tripObject.userId == userId;

        /// Document ID of the current Firestore doc
        String? documentId = docs?[index].id;

        return TripItemWidget(
          imageUrl: tripObject.imageUrl,
          name: tripObject.tripName,
          startLocation: tripObject.tripStart,
          description: formattedStartDate,
          docId: documentId,
          isYourJob: isYourJob,
          hasJoined: hasJoined,
        );
      }),
    );
  }
}
