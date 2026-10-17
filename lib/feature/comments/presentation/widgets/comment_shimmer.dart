import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 16.r, backgroundColor: appTheme.surfaceColor),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12.h,
                    width: 100.w,
                    color: appTheme.surfaceColor,
                  ),
                  6.verticalSpace,
                  Container(
                    height: 12.h,
                    width: double.infinity,
                    color: appTheme.surfaceColor,
                  ),
                  6.verticalSpace,
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
      ),
    );
  }
}
