import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class SessionsShimmer extends StatelessWidget {
  const SessionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final placeholder = appTheme.surfaceColor;

    return ShimmerList(
      padding: EdgeInsets.all(16.r),
      itemCount: 5,
      separator: 12.verticalSpace,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
              color: placeholder,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: appTheme.boarderPrimary),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(placeholder, width: 150.w, height: 16.h),
                8.verticalSpace,
                _line(placeholder, width: 230.w, height: 12.h),
                14.verticalSpace,
                _line(placeholder, width: 110.w, height: 12.h),
              ],
            ),
          );
        }

        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: placeholder,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: appTheme.boarderPrimary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: placeholder,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _line(placeholder, width: 140.w, height: 14.h),
                        7.verticalSpace,
                        _line(placeholder, width: 80.w, height: 11.h),
                      ],
                    ),
                  ),
                ],
              ),
              14.verticalSpace,
              _line(placeholder, width: 180.w, height: 12.h),
              12.verticalSpace,
              _line(placeholder, width: 160.w, height: 11.h),
              8.verticalSpace,
              _line(placeholder, width: 130.w, height: 11.h),
              8.verticalSpace,
              _line(placeholder, width: 150.w, height: 11.h),
            ],
          ),
        );
      },
    );
  }

  Widget _line(Color color, {required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
