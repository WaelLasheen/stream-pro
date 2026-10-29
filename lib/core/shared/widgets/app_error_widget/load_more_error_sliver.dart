import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

class LoadMoreErrorSliver extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const LoadMoreErrorSliver({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: appTheme.errorColor),
            ),
            if (onRetry != null) ...[
              8.verticalSpace,
              TextButton(
                onPressed: onRetry,
                child: Text(
                  S.current.retry,
                  style: TextStyle(color: appTheme.primaryColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
