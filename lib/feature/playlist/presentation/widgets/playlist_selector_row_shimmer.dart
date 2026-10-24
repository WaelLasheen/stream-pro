import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class PlaylistSelectorRowShimmer extends StatelessWidget {
  const PlaylistSelectorRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: appTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 12.h,
                  width: 120.w,
                  color: appTheme.backgroundColor,
                ),
                6.verticalSpace,
                Container(
                  height: 10.h,
                  width: 60.w,
                  color: appTheme.backgroundColor,
                ),
              ],
            ),
          ),
          Container(
            width: 22.w,
            height: 22.h,
            decoration: BoxDecoration(
              color: appTheme.backgroundColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}
