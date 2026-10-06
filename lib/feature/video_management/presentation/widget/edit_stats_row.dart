import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:stream_pro/feature/video_management/domain/entities/managed_video_entity.dart';

class EditStatsRow extends StatelessWidget {
  final ManagedVideoEntity video;
  const EditStatsRow({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget stat(IconData icon, int value) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp, color: theme.hintColor),
        SizedBox(width: 4.w),
        Text('$value', style: FontStyles.bodySmall),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        stat(Icons.visibility_outlined, video.views),
        stat(Icons.thumb_up_outlined, video.likesCount),
        stat(Icons.comment_outlined, video.commentsCount),
      ],
    );
  }
}
