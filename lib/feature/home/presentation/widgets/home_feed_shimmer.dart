import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class HomeFeedShimmer extends StatelessWidget {
  const HomeFeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final baseColor = appTheme.grey500;
    final highlightColor = appTheme.grey200;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListView.builder(
        padding: EdgeInsets.all(16.r),
        itemCount: 2,
        itemBuilder: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Shimmer
            Row(
              children: [
                Container(
                  width: 160.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: appTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                8.horizontalSpace,
                Container(
                  width: 60.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    color: appTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            // Cards Row Shimmer
            SizedBox(
              height: 290.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (_, __) => Container(
                  width: 300.w,
                  margin: EdgeInsets.only(right: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180.h,
                        decoration: BoxDecoration(
                          color: appTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      12.verticalSpace,
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: appTheme.surfaceColor,
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 14.h,
                                  color: appTheme.surfaceColor,
                                ),
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
                  ),
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
