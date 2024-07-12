import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../features/splash/splash_screen.dart';
import '../../../shared/helpers/shared_preferences_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/spacing.dart';
import '../../../utils/styles.dart';
import '../../home/widgets/home_body_loading.dart';
import '../widgets/settings_list_item.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String? userId;
  String? userName;
  String? userEmail;
  String? userCreatedDate;
  final Stream<QuerySnapshot<Map<String, dynamic>>> _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    super.initState();
    userId = SharedPreferencesManager.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: StreamBuilder(
        stream: _userStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const LoadingWidget();

          // find out the current users data obj from the users collection
          final userData = snapshot.data?.docs
              .firstWhere((e) => e['user_id'] == userId)
              .data() as Map;
          // user name
          userName = userData['name'];
          userEmail = userData['email'];
          userCreatedDate = DateFormat('MMMM dd yyyy')
              .format(DateTime.parse((userData['created_date']).toString()));

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              gv70,

              /// User Name, Animation and Joined Date Display widget
              UserNameImageWidget(
                userName: userName,
                userCreatedDate: userCreatedDate,
              ),

              gv10,

              /// User Data Display Widget
              UserDataWidget(
                userName: userName,
                userEmail: userEmail,
                userCreatedDate: userCreatedDate,
              ),

              /// Spacing
              const Spacer(),

              /// Signout Button
              const SignoutButton(),

              /// Spacing
              gv30
            ],
          );
        },
      ),
    );
  }
}

class UserNameImageWidget extends StatelessWidget {
  const UserNameImageWidget({
    super.key,
    required this.userName,
    required this.userCreatedDate,
  });

  final String? userName;
  final String? userCreatedDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppConstants.personLottie,
            width: 90.r,
          ),
          gv20,
          Text(
            userName ?? '..',
            style: AppStyles.tsFS20C00W700,
          ),
          Text(
            'Joined on $userCreatedDate',
            style: AppStyles.tsFS14CGreyW400,
          ),
        ],
      ),
    );
  }
}

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userCreatedDate,
  });

  final String? userName;
  final String? userEmail;
  final String? userCreatedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(width: 0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gv20,
          Padding(
            padding: EdgeInsets.only(left: 20.0.w),
            child: Text(
              'General',
              style: AppStyles.tsFS18C00W700,
            ),
          ),
          gh10,
          SettingsListItem(
            itemName: userName ?? '...',
            leading: const Icon(Icons.person_2_outlined),
          ),
          SettingsListItem(
            itemName: userEmail ?? '...',
            leading: const Icon(Icons.mail_outline_rounded),
          ),
          SettingsListItem(
            itemName: userCreatedDate ?? '...',
            leading: const Icon(Icons.phone_android),
          ),
          ListTile(
            title: Text(
              'Feedback',
              style: AppStyles.tsFS16C00W400,
            ),
            leading: const Icon(Icons.feedback),
          ),
          gv20,
        ],
      ),
    );
  }
}

class SignoutButton extends StatelessWidget {
  const SignoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
            child: const Text('Logout')));
  }
}
