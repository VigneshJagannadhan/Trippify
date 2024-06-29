import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:trippify/features/auth/auth_screen.dart';
import 'package:trippify/features/splash/splash_screen.dart';
import 'package:trippify/utils/providers.dart';
import 'firebase_options.dart';
import 'utils/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders(),
      child: MaterialApp(
        home: const SplashScreen(),
        theme: appTheme(),
      ),
    );
  }
}
