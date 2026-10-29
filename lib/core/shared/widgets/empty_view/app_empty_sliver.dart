import 'package:flutter/material.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/generated/l10n.dart';

class AppEmptySliver extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool hasScrollBody;

  const AppEmptySliver({
    super.key,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.iconSize,
    this.iconColor,
    this.messageStyle,
    this.padding,
    this.actionLabel,
    this.onAction,
    this.hasScrollBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: hasScrollBody,
      child: AppEmptyWidget(
        message: message ?? S.current.noDataAvailable,
        icon: icon,
        iconSize: iconSize,
        iconColor: iconColor,
        messageStyle: messageStyle,
        padding: padding,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
    );
  }
}
