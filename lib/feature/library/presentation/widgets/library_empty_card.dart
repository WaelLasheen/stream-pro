import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_inline_card.dart';

class LibraryEmptyCard extends StatelessWidget {
  final IconData icon;
  final String message;

  const LibraryEmptyCard({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    return LibraryInlineCard(
      child: Row(
        children: [
          Icon(icon, size: 30.r, color: appTheme.grey500),
          14.horizontalSpace,
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appTheme.textSecondary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
