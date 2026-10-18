import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class WatchHistoryLoadingWidget extends StatelessWidget {
  const WatchHistoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final shimmerLabel = Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: Container(
        height: 20.h,
        width: 100.w,
        color: appTheme.surfaceColor,
        margin: EdgeInsets.symmetric(vertical: 8.h),
      ),
    );

    return ShimmerList(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      itemCount: 3,
      separator: 16.verticalSpace,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerLabel,
            const VideoCardShimmer(variant: VideoCardVariant.horizontal),
            const VideoCardShimmer(variant: VideoCardVariant.horizontal),
          ],
        );
      },
    );
  }
}
