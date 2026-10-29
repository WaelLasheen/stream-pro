import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/like_button.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_selector_sheet.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/action_button.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/download_button.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/watch_later_button.dart';
import 'package:stream_pro/generated/l10n.dart';

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
            label: S.current.share,
            onTap: () {
              context.showSuccessSnackBar(message: S.current.shareLinkCopied);
            },
          ),
          SizedBox(width: 12.w),
          ActionButton(
            icon: Icons.playlist_add_outlined,
            label: S.current.save,
            onTap: () {
              PlaylistSelectorSheet.show(context, videoId: videoId);
            },
          ),
          SizedBox(width: 12.w),
          WatchLaterButton(videoId: videoId),
          SizedBox(width: 12.w),
          DownloadButton(videoId: videoId),
        ],
      ),
    );
  }
}
