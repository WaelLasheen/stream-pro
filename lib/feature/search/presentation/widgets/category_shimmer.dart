import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class CategoryFilterBarShimmer extends StatelessWidget {
  const CategoryFilterBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return SizedBox(
      height: 40.h,
      child: ShimmerList(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        separator: 8.horizontalSpace,
        itemBuilder: (context, index) {
          // Varying widths to simulate different category name lengths realistically
          final width = index == 0 ? 60.w : (70.w + (index * 15));

          return Container(
            width: width,
            height: 36.h,
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
          );
        },
      ),
    );
  }
}
