import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/generated/l10n.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final String? retryLabel;
  final IconData? retryIcon;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
    this.iconSize,
    this.iconColor,
    this.messageStyle,
    this.padding,
    this.retryLabel,
    this.retryIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize ?? 48.r,
              color: iconColor ?? theme.colorScheme.error,
            ),
            12.verticalSpace,
            Text(
              message,
              textAlign: TextAlign.center,
              style: messageStyle ?? theme.textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              16.verticalSpace,
              AppButton(
                text: retryLabel ?? S.current.retry,
                onPressed: onRetry!,
                icon: retryIcon != null ? Icon(retryIcon, size: 18.r) : null,
                width: 140.w,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
