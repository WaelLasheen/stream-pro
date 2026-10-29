import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/generated/l10n.dart';

class AppEmptyWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppEmptyWidget({
    super.key,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.iconSize,
    this.iconColor,
    this.messageStyle,
    this.padding,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize ?? 56.r,
                color: iconColor ?? theme.hintColor,
              ),
              12.verticalSpace,
            ],
            Text(
              message ?? S.current.noDataAvailable,
              textAlign: TextAlign.center,
              style: messageStyle ?? theme.textTheme.bodyMedium,
            ),
            if (onAction != null && actionLabel != null) ...[
              16.verticalSpace,
              ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
