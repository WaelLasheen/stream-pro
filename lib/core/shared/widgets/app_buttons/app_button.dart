import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Widget? icon;
  final BorderSide? border;
  final double? width;
  final double? height;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;
  final bool isIconTrailing;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.border,
    this.width,
    this.height,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.isIconTrailing = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent() {
      if (isLoading) {
        return SizedBox(
          height: 24.h,
          width: 24.h,
          child: CircularProgressIndicator(
            color: isPrimary
                ? (textColor ?? Colors.white)
                : Theme.of(context).primaryColor,
            strokeWidth: 2.w,
          ),
        );
      }

      if (icon == null) {
        return Text(text);
      }

      final content = [
        if (!isIconTrailing) icon!,
        if (!isIconTrailing) SizedBox(width: 8.w),
        Text(text),
        if (isIconTrailing) SizedBox(width: 8.w),
        if (isIconTrailing) icon!,
      ];

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: content,
      );
    }

    final buttonStyle = isPrimary
        ? ElevatedButton.styleFrom(
            side: border,
            backgroundColor: backgroundColor,
            shape: borderRadius != null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  )
                : null,
            textStyle: TextStyle(
              fontFamily: 'Rubik',
              fontSize: fontSize?.sp ?? 16.sp,
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: textColor ?? Colors.white,
            elevation: backgroundColor != null ? 0 : null,
            padding: EdgeInsets.zero,
          )
        : OutlinedButton.styleFrom(
            side: border,
            foregroundColor: textColor,
            shape: borderRadius != null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  )
                : null,
            textStyle: TextStyle(
              fontFamily: 'Rubik',
              fontSize: fontSize?.sp ?? 16.sp,
              fontWeight: FontWeight.w500,
            ),
            padding: EdgeInsets.zero,
          );

    return SizedBox(
      width: isFullWidth ? (width ?? context.screenWidth) : width,
      height: height?.h ?? 48.h,
      child: isPrimary
          ? ElevatedButton(
              onPressed: isLoading ? () {} : onPressed,
              style: buttonStyle,
              child: buttonContent(),
            )
          : OutlinedButton(
              onPressed: isLoading ? () {} : onPressed,
              style: buttonStyle,
              child: buttonContent(),
            ),
    );
  }
}
