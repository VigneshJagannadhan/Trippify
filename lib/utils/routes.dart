import 'package:flutter/material.dart';
import 'package:trippify/features/auth/views/auth_screen.dart';
import 'package:trippify/features/home/views/home_screen.dart';
import 'package:trippify/features/splash/splash_screen.dart';

String initialRoute = SplashScreen.route;

Map<String, WidgetBuilder> get routes => {
      SplashScreen.route: (context) => const SplashScreen(),
      AuthScreen.route: (context) => AuthScreen(),
      HomeScreen.route: (context) => const HomeScreen(),
    };
