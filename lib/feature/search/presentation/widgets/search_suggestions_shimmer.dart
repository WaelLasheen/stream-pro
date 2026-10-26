import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class SearchSuggestionsShimmer extends StatelessWidget {
  const SearchSuggestionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return ShimmerList(
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemBuilder: (_, __) => Row(
        children: [
          Container(
            width: 96.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12.h, color: appTheme.surfaceColor),
                8.verticalSpace,
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
    );
  }
}
