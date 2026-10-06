import 'package:flutter/material.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';

class AppErrorSliver extends StatelessWidget {
  final bool hasScrollBody;
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final String retryLabel;
  final IconData? retryIcon;

  const AppErrorSliver({
    super.key,
    this.hasScrollBody = false,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
    this.iconSize,
    this.iconColor,
    this.messageStyle,
    this.padding,
    this.retryLabel = 'Retry',
    this.retryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: hasScrollBody,
      child: AppErrorWidget(
        message: message,
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        messageStyle: messageStyle,
        onRetry: onRetry,
        padding: padding,
        retryIcon: retryIcon,
        retryLabel: retryLabel,
      ),
    );
  }
}
