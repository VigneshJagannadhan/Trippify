import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trippify/features/auth/repository/auth_repo.dart';
import 'package:trippify/features/shared/view_models/loading.viewmodel.dart';
import 'package:trippify/utils/constants.dart';
import '../../home/views/home_screen.dart';
import '../../shared/helpers/shared_preferences_manager.dart';
import '../../shared/widgets/general_error_popup.dart';
import '../models/user_model.dart';

class AuthViewModel extends LoadingViewModel {
  AuthViewModel({required this.repo});

  final AuthRepo repo;

  String? _email;
  String? get email => _email;

  String? _password;
  String? get password => _password;

  bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;

  set email(email) {
    _email = email;
    notifyListeners();
  }

  set password(password) {
    _password = password;
    notifyListeners();
  }

  set isPasswordVisible(isPasswordVisible) {
    _isPasswordVisible = isPasswordVisible;
    notifyListeners();
  }

  registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      UserCredential? credential = await repo.registerUser(
        name: name,
        email: email,
        password: password,
        context: context,
      );
      UserModel userModel = UserModel(
        credential?.user!.uid,
        name,
        email,
        DateTime.now().toString(),
      );

      final user = userModel.toJson();

      if (credential?.user?.uid != null) {
        await SharedPreferencesManager.setUserId(credential?.user!.uid ?? '');
      }

      final db = FirebaseFirestore.instance;
      db.collection("users").add(user).then((DocumentReference doc) {
        log('DocumentSnapshot added with ID: ${doc.id}');
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    try {
      UserCredential? credential = await repo.loginUser(
          email: email, password: password, context: context);

      log('CREDENTIAL : ${credential.toString()}');

      if (credential?.user?.uid != null) {
        await SharedPreferencesManager.setUserId(credential?.user!.uid ?? '');
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String header = 'Oops! Something went wrong';
      String message = 'Please try again.';
      String lottieUrl = AppConstants.commonErrorsLottie;
      switch (e.code) {
        case 'user-not-found':
          header = 'User Not Found';
          message = 'This email is not associated with any user.';
          lottieUrl = AppConstants.commonErrorsLottie;
        case 'wrong-password':
          header = 'Wrong Password';
          message = 'The password provided for this user is incorrect';
          lottieUrl = AppConstants.wrongPasswordLottie;
          break;
        default:
      }

      showGeneralPopup(
        context: context,
        header: header,
        lottieUrl: lottieUrl,
        message: message,
      );
    } catch (e) {
      log('GENERAL ERROR : ${e.toString()}');
      showGeneralPopup(
        context: context,
        header: 'Oops! Something went wrong',
        lottieUrl: AppConstants.commonErrorsLottie,
        message: e.toString(),
      );
    }

    isLoading = false;
  }

  Future<dynamic> showGeneralPopup({
    required BuildContext context,
    required String header,
    required String message,
    required String lottieUrl,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          headerText: header,
          bodyText: message,
          lottieUrl: lottieUrl,
          onPressed: () {
            log('OK button pressed');
          },
        );
      },
    );
  }
}
