import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trippify/features/auth/views/auth_screen.dart';
import 'package:trippify/features/home/views/home_screen.dart';
import 'package:trippify/utils/constants.dart';
import 'package:trippify/utils/styles.dart';

import '../../utils/spacing.dart';

class SplashScreen extends StatefulWidget {
  static const String route = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      await Future.delayed(const Duration(seconds: 2));
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AuthScreen(),
              ),
            );
          }
        } else {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 1.h,
                width: 1.sw,
                child: Lottie.asset(AppConstants.splashScreenLottie4)),
            gv50,
            Text(
              'Trippify',
              style: AppStyles.tsFS50CPW600,
            ),
            gv50,
            const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
