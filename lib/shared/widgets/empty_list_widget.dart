import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/spacing.dart';
import '../../../utils/styles.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
    required this.lottieAsset,
    required this.emptyListText,
  });

  final String lottieAsset;
  final String emptyListText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        gv80,
        Lottie.asset(lottieAsset),
        gv20,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(emptyListText,
              style: AppStyles.tsFS14C00W400, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
