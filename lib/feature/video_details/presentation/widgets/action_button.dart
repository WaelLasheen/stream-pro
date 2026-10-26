import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: appTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: appTheme.grey700),
            SizedBox(width: 6.w),
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(color: appTheme.grey700),
            ),
          ],
        ),
      ),
    );
  }
}
