import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class ChannelHeaderShimmer extends StatelessWidget {
  const ChannelHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: appTheme.surfaceColor),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: appTheme.surfaceColor,
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16.h,
                            width: double.infinity,
                            color: appTheme.surfaceColor,
                          ),
                          8.verticalSpace,
                          Container(
                            height: 12.h,
                            width: 180.w,
                            color: appTheme.surfaceColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Container(
                  height: 12.h,
                  width: double.infinity,
                  color: appTheme.surfaceColor,
                ),
                8.verticalSpace,
                Container(
                  height: 12.h,
                  width: 220.w,
                  color: appTheme.surfaceColor,
                ),
                12.verticalSpace,
                Container(
                  height: 38.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: appTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
