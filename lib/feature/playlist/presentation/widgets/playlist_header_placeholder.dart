import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistHeaderPlaceholder extends StatelessWidget {
  const PlaylistHeaderPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.playlist_play_outlined,
          size: 42.r,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
