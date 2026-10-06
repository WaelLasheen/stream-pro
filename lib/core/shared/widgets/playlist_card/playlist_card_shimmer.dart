import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_data.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';

class PlaylistCardShimmer extends StatelessWidget {
  final PlaylistCardVariant variant;

  const PlaylistCardShimmer({
    super.key,
    this.variant = PlaylistCardVariant.vertical,
  });

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
        child: variant == PlaylistCardVariant.vertical
            ? const _VerticalPlaylistShimmer()
            : const _HorizontalPlaylistShimmer(),
      ),
    );
  }
}

class _VerticalPlaylistShimmer extends StatelessWidget {
  const _VerticalPlaylistShimmer();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 200.h,
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: appTheme.surfaceColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            Positioned.fill(
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(width: 45.w, color: appTheme.grey500),
                ),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 14.h,
                width: 180.w,
                color: appTheme.surfaceColor,
              ),
              8.verticalSpace,
              Container(
                height: 12.h,
                width: 80.w,
                color: appTheme.surfaceColor,
              ),
              6.verticalSpace,
              Container(
                height: 12.h,
                width: double.infinity,
                color: appTheme.surfaceColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HorizontalPlaylistShimmer extends StatelessWidget {
  const _HorizontalPlaylistShimmer();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 140.w,
              height: 90.h,
              decoration: BoxDecoration(
                color: appTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            Positioned.fill(
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(width: 30.w, color: appTheme.grey500),
                ),
              ),
            ),
          ],
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 14.h,
                width: double.infinity,
                color: appTheme.surfaceColor,
              ),
              8.verticalSpace,
              Container(
                height: 12.h,
                width: 60.w,
                color: appTheme.surfaceColor,
              ),
              6.verticalSpace,
              Container(
                height: 12.h,
                width: 100.w,
                color: appTheme.surfaceColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
