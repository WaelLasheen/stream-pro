import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/like_button.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/widget/download_button.dart';

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

          ActionButton(
            icon: Icons.comment_outlined,
            label: '$commentsCount',
            onTap: () {},
          ),
          SizedBox(width: 12.w),

          ActionButton(
            icon: Icons.share_outlined,
            label: 'Share',
            onTap: () {
              context.showSuccessSnackBar(message: 'Share link copied!');
            },
          ),
          SizedBox(width: 12.w),
          DownloadButton(videoId: videoId),
        ],
      ),
    );
  }
}

// Renamed from _ActionButton to ActionButton to allow cross-file usage
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: appTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: appTheme.grey700),
            SizedBox(width: 6.w),
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(color: appTheme.grey700),
            ),
          ],
        ),
      ),
    );
  }
}
