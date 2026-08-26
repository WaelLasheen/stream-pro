import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_likes_cubit/video_likes_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_likes_cubit/video_likes_state.dart';

class VideoActionsWidget extends StatelessWidget {
  final String videoId;
  final int commentsCount;

  const VideoActionsWidget({
    super.key,
    required this.videoId,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoLikesCubit, VideoLikesState>(
      listener: (context, state) {
        if (state is VideoLikesFailure) {
          context.showErrorSnackBar(message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Like Button Action
              _ActionButton(
                icon: state.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_off_alt,
                iconColor: state.isLiked ? Theme.of(context).primaryColor : null,
                label: '${state.likesCount}',
                onTap: () {
                  context.read<VideoLikesCubit>().toggleLike(videoId);
                },
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
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: iconColor),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}