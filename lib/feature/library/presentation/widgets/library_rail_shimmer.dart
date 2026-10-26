import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';

class LibraryRailShimmer extends StatelessWidget {
  const LibraryRailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SizedBox(
      height: context.libraryRailHeight,
      child: ShimmerList(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 3,
        separator: 12.horizontalSpace,
        itemBuilder: (_, __) => SizedBox(
          width: VideoCardWidget.compactWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: VideoCardWidget.compactThumbnailHeight,
                decoration: BoxDecoration(
                  color: appTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              10.verticalSpace,
              Container(height: 12.h, color: appTheme.surfaceColor),
              6.verticalSpace,
              Container(
                height: 10.h,
                width: 100.w,
                color: appTheme.surfaceColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
