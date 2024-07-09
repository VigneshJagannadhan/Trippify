import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future<UserCredential?>? loginUser({
    required String email,
    required String password,
    required BuildContext context,
  });
  Future<UserCredential?>? registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  });
}

class AuthRepoImpl extends AuthRepo {
  @override
  Future<UserCredential?> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential;
  }

  @override
  Future<UserCredential?>? registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential;
  }
}
