import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippify/features/home/home_screen.dart';
import 'package:trippify/utils/colors.dart';
import 'package:trippify/utils/sp_keys.dart';
import 'package:trippify/utils/styles.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/3.jpg'),
            //       fit: BoxFit.cover,
            //       alignment: Alignment.centerRight,
            //     ),
            //   ),
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            //     child: Container(
            //       decoration:
            //           BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                color: color00000000,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      !isLogin ? 'Sign up' : 'Sign in',
                      style: AppStyles.tsFS70CPW600shadowsIntoLight,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (!isLogin)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(
                              'Name',
                              style: AppStyles.tsFS12C00W600,
                            ),
                          ),
                          controller: nameController,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'Email',
                        style: AppStyles.tsFS12C00W600,
                      ),
                    ),
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                        style: AppStyles.tsFS12C00W600,
                      ),
                    ),
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        isLogin = !isLogin;
                        setState(() {});
                      },
                      child: Text(
                        isLogin
                            ? 'New user? Sign up '
                            : 'Already have an account? Sign in ',
                        style: AppStyles.tsFS12CFFW600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        isLogin ? await loginUser() : await registerUser();
                      },
                      child: Text(isLogin ? 'Login' : 'Register User'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (credential.user?.uid != null) {
        preferences.setString(sp_user_id, credential.user!.uid);
      }

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future<void> registerUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (credential.user?.uid != null) {
        preferences.setString(sp_user_id, credential.user!.uid);
      }

      final db = FirebaseFirestore.instance;
      final user = <String, dynamic>{
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "user_id": credential.user!.uid,
        "created_date": DateTime.now().toString(),
      };

      db.collection("users").add(user).then((DocumentReference doc) {
        log('DocumentSnapshot added with ID: ${doc.id}');
      });

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
