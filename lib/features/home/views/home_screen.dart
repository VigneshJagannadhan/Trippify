import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trippify/features/home/views/chat_body.dart';
import 'package:trippify/features/home/views/home_screen_body.dart';
import 'package:trippify/features/home/view_models/home.viewmodel.dart';
import 'package:trippify/features/home/widgets/home_body_loading.dart';
import 'package:trippify/features/settings/views/settings_view.dart';
import 'package:trippify/features/trips/views/my_trips_body.dart';
import 'package:trippify/utils/colors.dart';
import 'package:trippify/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  Stream<QuerySnapshot<Object?>>? myTripsStream;
  Stream<QuerySnapshot<Object?>>? chatsStream;

  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      viewModel.fetchAllTrips();
      viewModel.fetchMyChats();
      viewModel.fetchMyTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: colorFFFFFFFF,
        body: Consumer<HomeViewModel>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget();
          }
          return TabBarView(
            children: [
              HomeScreenBody(
                stream: viewModel.allTripsModel,
              ),
              ChatBody(
                stream: viewModel.myChatModel,
              ),
              MyTripsBody(
                stream: viewModel.myTripsModel,
              ),
              const SettingsView(),
            ],
          );
        }),
        bottomNavigationBar: TabBar(
          tabs: [
            SizedBox(
              height: 100.h,
              child: SvgPicture.asset(AppConstants.homeSvg),
            ),
            SizedBox(
              height: 100.h,
              child: SvgPicture.asset(AppConstants.chatSvg),
            ),
            SizedBox(
              height: 100.h,
              child: SvgPicture.asset(AppConstants.myTripsSvg),
            ),
            SizedBox(
              height: 100.h,
              child: SvgPicture.asset(AppConstants.profileSvg),
            ),
          ],
          labelColor: Colors.yellow,
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0.r),
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}
