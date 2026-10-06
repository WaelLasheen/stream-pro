import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'video_card_data.dart';

class VideoCardShimmer extends StatelessWidget {
  final VideoCardVariant variant;

  const VideoCardShimmer({super.key, this.variant = VideoCardVariant.vertical});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final baseColor = appTheme.grey500;
    final highlightColor = appTheme.grey200;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: variant == VideoCardVariant.vertical
            ? const _VerticalVideoCardShimmer()
            : const _HorizontalVideoCardShimmer(),
      ),
    );
  }
}

class _VerticalVideoCardShimmer extends StatelessWidget {
  const _VerticalVideoCardShimmer();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail placeholder
        Container(
          height: 200.h,
          width: context.screenWidth,
          decoration: BoxDecoration(
            color: appTheme.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        12.verticalSpace,
        // Channel avatar + title/meta placeholder
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 20.r, backgroundColor: appTheme.surfaceColor),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14.h, color: appTheme.surfaceColor),
                  6.verticalSpace,
                  Container(
                    height: 12.h,
                    width: 120.w,
                    color: appTheme.surfaceColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HorizontalVideoCardShimmer extends StatelessWidget {
  const _HorizontalVideoCardShimmer();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail placeholder
        Container(
          width: 140.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: appTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        10.horizontalSpace,
        // Details placeholder (Title + Meta info)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 14.h, color: appTheme.surfaceColor),
              6.verticalSpace,
              Container(
                height: 14.h,
                width: 100.w,
                color: appTheme.surfaceColor,
              ),
              12.verticalSpace,
              Container(
                height: 12.h,
                width: 80.w,
                color: appTheme.surfaceColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
