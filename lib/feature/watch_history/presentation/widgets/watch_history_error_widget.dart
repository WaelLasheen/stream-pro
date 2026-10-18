import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class WatchHistoryErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const WatchHistoryErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = Theme.of(context).textTheme;

    return AppErrorWidget(
      message: message,
      onRetry: onRetry,
      icon: Icons.error_outline_rounded,
      iconSize: 56.r,
      iconColor: appTheme.errorColor,
      messageStyle: textTheme.bodyMedium?.copyWith(
        color: appTheme.textSecondary,
      ),
    );
  }
}
