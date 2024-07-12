import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../features/auth/view_models/auth.viewmodel.dart';
import '../../../utils/colors.dart';
import '../../../utils/spacing.dart';
import '../../../utils/styles.dart';
import '../../../utils/validators.dart';

class AuthScreen extends StatefulWidget {
  static const String route = 'auth';
  AuthScreen({super.key, this.isLogin = true});
  bool isLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: colorFFFFFFFF,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gv100,
                Text(
                  !(widget.isLogin) ? 'Sign up' : 'Sign in',
                  style: AppStyles.tsFS50CPW600,
                ),
                gv50,
                if (!(widget.isLogin))
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
                gv20,
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: AppStyles.tsFS12C00W600,
                    ),
                  ),
                  controller: emailController,
                  validator: validateEmail,
                ),
                gv20,
                Consumer<AuthViewModel>(builder: (context, viewmodel, child) {
                  return TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                        style: AppStyles.tsFS12C00W600,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(viewmodel.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => viewmodel.isPasswordVisible =
                            !(viewmodel.isPasswordVisible),
                      ),
                    ),
                    controller: passwordController,
                    validator: validatePassword,
                    obscureText: viewmodel.isPasswordVisible,
                  );
                }),
                gv10,
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isLogin) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AuthScreen(
                            isLogin: false,
                          ),
                        ));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AuthScreen(
                            isLogin: true,
                          ),
                        ));
                      }
                    },
                    child: Text(
                      widget.isLogin
                          ? 'New user? Sign up '
                          : 'Already have an account? Sign in ',
                      style: AppStyles.tsFS12CPW500,
                    ),
                  ),
                ),
                const Spacer(),
                Consumer<AuthViewModel>(builder: (context, viewModel, child) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    child: viewModel.isLoading
                        ? const CupertinoActivityIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                widget.isLogin
                                    ? await viewModel.loginUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                      )
                                    : await viewModel.registerUser(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                      );
                              }
                            },
                            child: Text(
                                widget.isLogin ? 'Login' : 'Register User'),
                          ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
