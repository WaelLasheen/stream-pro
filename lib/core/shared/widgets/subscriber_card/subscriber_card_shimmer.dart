import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class SubscriberCardShimmer extends StatelessWidget {
  const SubscriberCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final shimmerColor = appTheme.surfaceColor;

    return Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: appTheme.grey500.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 24.r, backgroundColor: shimmerColor),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14.h, width: 120.w, color: shimmerColor),
                  6.verticalSpace,
                  Container(height: 12.h, width: 160.w, color: shimmerColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
