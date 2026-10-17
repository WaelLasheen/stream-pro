import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class ReplyingBadgeWidget extends StatelessWidget {
  final String userName;

  const ReplyingBadgeWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: appTheme.primaryTint.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: appTheme.boarderPrimary, width: 1.w),
      ),
      child: Text(
        'Replying to @$userName',
        style: textTheme.labelMedium?.copyWith(
          color: appTheme.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}