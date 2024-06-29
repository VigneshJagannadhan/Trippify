import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippify/features/splash/splash_screen.dart';
import 'package:trippify/utils/sp_keys.dart';
import 'package:trippify/utils/spacing.dart';
import 'package:trippify/utils/styles.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((e) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userId = preferences.getString(sp_user_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: StreamBuilder(
        stream: _userStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
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
                SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        // backgroundImage: NetworkImage(url),
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
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 0.2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gv30,
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
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
                ),
                const Spacer(),
                const SignoutButton(),
                gv50
              ],
            );
          } else {
            return const Text('Loading...');
          }
        },
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

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.itemName,
    this.onTap,
    this.leading,
  });

  final String itemName;
  final Function()? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text(
              itemName,
              style: AppStyles.tsFS16C00W400,
            ),
            leading: leading ?? const SizedBox(),
            onTap: onTap),
        const Divider(),
      ],
    );
  }
}
