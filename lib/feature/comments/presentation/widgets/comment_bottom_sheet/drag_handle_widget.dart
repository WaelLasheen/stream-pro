import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class DragHandleWidget extends StatelessWidget {
  const DragHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: appTheme.grey500.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}