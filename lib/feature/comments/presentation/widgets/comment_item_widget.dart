import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/dialog_extension.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/params/user_params.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/more_menu.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/replies_thread.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/top_level_actions.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentEntity comment;
  final String videoId;
  final UserParams currentUser;
  final bool isReply;
  final String? parentId;
  final void Function(CommentEntity parentComment)? onReply;
  final void Function(CommentEntity comment)? onEditTopLevel;
  final void Function(CommentEntity reply, String parentId)? onEditReply;

  const CommentItemWidget({
    super.key,
    required this.comment,
    required this.videoId,
    required this.currentUser,
    this.isReply = false,
    this.parentId,
    this.onReply,
    this.onEditTopLevel,
    this.onEditReply,
  });

  bool get isOwner =>
      comment.userId.isNotEmpty && comment.userId == currentUser.userId;

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await context.showDeleteConfirmationDialog(
      title: isReply ? 'Delete reply?' : 'Delete comment?',
      content: isReply
          ? 'This reply will be permanently removed. This can\'t be undone.'
          : 'This comment will be permanently removed. This can\'t be undone.',
    );

    if (confirmed != true || !context.mounted) return;

    if (isReply) {
      final pid = parentId;
      if (pid == null) return;
      context.read<RepliesCubit>().deleteReply(
        parentId: pid,
        commentId: comment.commentId,
        onSuccess: () => context.read<CommentsCubit>().decrementReplyCount(pid),
        onFailure: () => context.read<CommentsCubit>().incrementReplyCount(pid),
      );
    } else {
      context.read<CommentsCubit>().deleteComment(comment.commentId);
    }
  }

  void _onEdit(BuildContext context) {
    if (isReply) {
      final pid = parentId;
      if (pid == null || onEditReply == null) return;
      onEditReply!(comment, pid);
    } else {
      onEditTopLevel?.call(comment);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;
    final displayName = comment.userName.isEmpty ? 'You' : comment.userName;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isReply)
            Container(
              width: 2.w,
              height: 36.h,
              margin: EdgeInsets.only(right: 10.w, top: 4.h),
              decoration: BoxDecoration(
                color: appTheme.boarderPrimary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppCircleNetworkImage(
                      imageUrl: comment.userProfileImage,
                      radius: isReply ? 13.r : 16.r,
                      fallbackText: displayName,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: displayName,
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: appTheme.textPrimary,
                                fontSize: isReply ? 12.sp : 13.sp,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '  •  ${comment.createdAt.timeAgo()}${comment.isEdited ? '  •  edited' : ''}',
                              style: textTheme.labelSmall?.copyWith(
                                color: appTheme.textSecondary,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isOwner)
                      MoreMenu(
                        onEdit: () => _onEdit(context),
                        onDelete: () => _confirmDelete(context),
                        showEdit: isReply
                            ? onEditReply != null
                            : onEditTopLevel != null,
                      ),
                  ],
                ),
                3.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isReply ? 36.r : 42.r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.content,
                        style: textTheme.bodyMedium?.copyWith(
                          color: appTheme.textPrimary,
                          fontSize: isReply ? 13.sp : 14.sp,
                          height: 1.4,
                        ),
                      ),
                      if (!isReply) ...[
                        SizedBox(height: 6.h),
                        TopLevelActions(comment: comment, onReply: onReply),
                        RepliesThread(
                          comment: comment,
                          videoId: videoId,
                          currentUser: currentUser,
                          onEditReply: onEditReply,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
