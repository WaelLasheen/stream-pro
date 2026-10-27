import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final placeholder = appTheme.surfaceColor;

    return Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        children: [
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: placeholder,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: appTheme.boarderPrimary),
            ),
            child: Column(
              children: [
                CircleAvatar(radius: 48.r, backgroundColor: placeholder),
                16.verticalSpace,
                Container(
                  height: 18.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: placeholder,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                10.verticalSpace,
                Container(
                  height: 12.h,
                  width: 210.w,
                  decoration: BoxDecoration(
                    color: placeholder,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                8.verticalSpace,
                Container(
                  height: 12.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: placeholder,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(child: _statCard(placeholder, appTheme.boarderPrimary)),
              12.horizontalSpace,
              Expanded(child: _statCard(placeholder, appTheme.boarderPrimary)),
            ],
          ),
          24.verticalSpace,
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: placeholder,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: appTheme.boarderPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(Color placeholder, Color borderColor) {
    return Container(
      height: 104.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: placeholder,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 12.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: placeholder,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          12.verticalSpace,
          Container(
            height: 22.h,
            width: 72.w,
            decoration: BoxDecoration(
              color: placeholder,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}
