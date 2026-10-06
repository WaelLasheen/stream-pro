import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/like_button.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';

class VideoActionsWidget extends StatelessWidget {
  final String videoId;
  final bool isLiked;
  final int likeCount;
  final int commentsCount;

  const VideoActionsWidget({
    super.key,
    required this.videoId,
    required this.isLiked,
    required this.likeCount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          LikeButton(
            videoId: videoId,
            initialIsLiked: isLiked,
            initialLikesCount: likeCount,
          ),
          SizedBox(width: 12.w),
          // Comments Indicator
          _ActionButton(
            icon: Icons.comment_outlined,
            label: '$commentsCount',
            onTap: () {},
          ),
          SizedBox(width: 12.w),
          // Share Button
          _ActionButton(
            icon: Icons.share_outlined,
            label: 'Share',
            onTap: () {
              context.showSuccessSnackBar(message: 'Share link copied!');
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp),
            SizedBox(width: 6.w),
            Text(label, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
