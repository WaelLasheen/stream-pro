import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_inline_card.dart';

class LibraryErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const LibraryErrorCard({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    return LibraryInlineCard(
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, size: 30.r, color: appTheme.errorColor),
          14.horizontalSpace,
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appTheme.textSecondary,
              ),
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
