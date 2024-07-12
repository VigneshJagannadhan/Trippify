import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/colors.dart';
import '../../../utils/spacing.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Join a trip Text Widget
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gv70,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                    ),
                    gh10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10.h,
                          width: 100.w,
                          color: colorFFFFFFFF,
                        ),
                        gv05,
                        Container(
                          height: 20.h,
                          width: 150.w,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
                gv30,
                Container(
                  height: 50.h,
                  width: 200.w,
                  color: Colors.amber,
                ),
                gv20,
                Column(
                  children: List.generate(
                    2,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 230.h,
                          decoration: BoxDecoration(
                            color: colorFFFFFFFF,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        gv20,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Trips List Builder and Empty Jobs List builder
        ],
      ),
    );
  }
}

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: child,
    );
  }
}
