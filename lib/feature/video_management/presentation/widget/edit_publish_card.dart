import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/generated/l10n.dart';

class EditPublishCard extends StatelessWidget {
  final bool isPublished;
  final bool isChanging;
  final bool enabled;
  final VoidCallback onToggle;

  const EditPublishCard({
    super.key,
    required this.isPublished,
    required this.isChanging,
    required this.enabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: SwitchListTile(
        value: isPublished,
        onChanged: enabled ? (_) => onToggle() : null,
        title: Text(
          isPublished
              ? S.current.visibleToEveryone
              : S.current.onlyYouCanSeeThisVideo,
        ),
        subtitle: Text(
          isPublished ? 'Visible to everyone' : 'Only you can see this video',
        ),
        secondary: isChanging
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                isPublished ? Icons.public : Icons.lock_outline,
                color: theme.hintColor,
              ),
      ),
    );
  }
}
