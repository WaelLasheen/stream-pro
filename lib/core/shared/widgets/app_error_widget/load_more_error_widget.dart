import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/generated/l10n.dart';

class LoadMoreErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const LoadMoreErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          if (onRetry != null) ...[
            8.verticalSpace,
            TextButton(onPressed: onRetry, child: Text(S.current.retry)),
          ],
        ],
      ),
    );
  }
}
