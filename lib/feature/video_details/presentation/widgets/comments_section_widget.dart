import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_state.dart';

class CommentsSectionWidget extends StatelessWidget {
  final String videoId;

  const CommentsSectionWidget({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<VideoCommentsCubit, VideoCommentsState>(
      listener: (context, state) {
        if (state is VideoCommentsFailure) {
          context.showErrorSnackBar(message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_comment_outlined),
                  onPressed: () => _showAddCommentBottomSheet(context, videoId),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            if (state is VideoCommentsLoading)
              const Center(child: CircularProgressIndicator())
            else if (state is VideoCommentsSuccess)
              state.comments.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const Center(
                        child: Text('No comments yet. Be the first!'),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.comments.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return _CommentItem(comment: comment, videoId: videoId);
                      },
                    ),
          ],
        );
      },
    );
  }

  void _showAddCommentBottomSheet(BuildContext context, String videoId) {
    final textController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 16.h,
            left: 16.w,
            right: 16.w,
            top: 16.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Add a comment...',
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final text = textController.text.trim();
                  if (text.isNotEmpty) {
                    final navigator = Navigator.of(bottomSheetContext);
                    final success = await context
                        .read<VideoCommentsCubit>()
                        .addComment(videoId, text);
                    if (success) {
                      navigator.pop();
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final String videoId;

  const _CommentItem({required this.comment, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundImage: comment.userProfileImage.isNotEmpty
              ? CachedNetworkImageProvider(comment.userProfileImage)
              : null,
          child: comment.userProfileImage.isEmpty
              ? Text(comment.userName.isNotEmpty ? comment.userName[0] : 'U')
              : null,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.userName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  if (comment.isEditted)
                    Text(
                      '(edited)',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(comment.content, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, size: 16.sp, color: theme.hintColor),
          onSelected: (value) {
            if (value == 'delete') {
              context.read<VideoCommentsCubit>().deleteComment(
                comment.commentId,
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ],
    );
  }
}
