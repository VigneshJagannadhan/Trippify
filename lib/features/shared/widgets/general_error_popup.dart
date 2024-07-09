import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trippify/utils/styles.dart';

class CustomPopup extends StatelessWidget {
  final String headerText;
  final String bodyText;
  final String lottieUrl;
  final Function onPressed;

  const CustomPopup({
    super.key,
    required this.headerText,
    required this.bodyText,
    required this.lottieUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
      title: Text(
        headerText,
        style: AppStyles.tsFS20C00W400,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100.h, child: Lottie.asset(lottieUrl)),
          Text(
            bodyText,
            style: AppStyles.tsFS14C00W400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        SizedBox(
          width: 1.sw,
          height: 50.h,
          child: ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              onPressed();
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ),
      ],
    );
  }
}
