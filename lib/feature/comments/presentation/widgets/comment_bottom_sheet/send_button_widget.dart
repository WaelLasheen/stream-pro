import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class SendButtonWidget extends StatelessWidget {
  final bool canSend;
  final bool isEditing;
  final VoidCallback onSubmit;

  const SendButtonWidget({
    super.key,
    required this.canSend,
    required this.isEditing,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: EdgeInsets.only(right: 8.w, bottom: 8.h, top: 8.h),
      child: GestureDetector(
        onTap: canSend ? onSubmit : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: canSend
                ? appTheme.primaryColor
                : appTheme.grey500.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isEditing ? Icons.check_rounded : Icons.send_rounded,
            size: 18.sp,
            color: appTheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
