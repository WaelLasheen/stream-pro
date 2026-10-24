import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class PlaylistHeaderShimmer extends StatelessWidget {
  const PlaylistHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: Container(height: 220.h, color: appTheme.surfaceColor),
    );
  }
}
