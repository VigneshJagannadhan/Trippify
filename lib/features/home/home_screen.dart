import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippify/features/chat/chat_body.dart';
import 'package:trippify/features/home/home_screen_body.dart';
import 'package:trippify/features/settings/settings_view.dart';
import 'package:trippify/features/trips/views/my_trips_body.dart';
import 'package:trippify/utils/constants.dart';
import 'package:trippify/utils/styles.dart';
import '../../utils/sp_keys.dart';
import '../trips/views/create_trips_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  Stream<QuerySnapshot<Object?>>? myTripsStream;
  Stream<QuerySnapshot<Object?>>? allTripsStream;
  Stream<QuerySnapshot<Object?>>? chatsStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userId = preferences.getString(sp_user_id);
      allTripsStream = FirebaseFirestore.instance
          .collection('trips')
          .where('user_id', isNotEqualTo: userId)
          .snapshots();
      chatsStream = FirebaseFirestore.instance
          .collection('chat')
          .where('joined_users', arrayContains: userId)
          .snapshots();
      myTripsStream = FirebaseFirestore.instance
          .collection('trips')
          .where('user_id', isEqualTo: userId)
          .snapshots();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
        body: TabBarView(
          children: [
            HomeScreenBody(
              stream: allTripsStream,
              userId: userId,
            ),
            ChatBody(
              stream: chatsStream,
              userId: userId,
            ),
            MyTripsBody(
              userId: userId ?? '',
              stream: myTripsStream,
            ),
            const SettingsView(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            SizedBox(
              height: 100,
              child: SvgPicture.asset(AppConstants.homeSvg),
            ),
            SizedBox(
              height: 100,
              child: SvgPicture.asset(AppConstants.chatSvg),
            ),
            SizedBox(
              height: 100,
              child: SvgPicture.asset(AppConstants.myTripsSvg),
            ),
            SizedBox(
              height: 100,
              child: SvgPicture.asset(AppConstants.profileSvg),
            ),
          ],
          labelColor: Colors.yellow,
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: Colors.red,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        //   child: Card(
        //     elevation: 5,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: 100,
        //       decoration: BoxDecoration(
        //         color: colorFFFFFFFF,
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           SvgPicture.asset(AppConstants.homeSvg),
        //           SvgPicture.asset(AppConstants.chatSvg),
        //           SvgPicture.asset(AppConstants.myTripsSvg),
        //           SvgPicture.asset(AppConstants.profileSvg),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
