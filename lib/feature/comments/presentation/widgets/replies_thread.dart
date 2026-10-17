import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_state.dart';
import 'package:stream_pro/feature/comments/presentation/params/user_params.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_item_widget.dart';

class RepliesThread extends StatelessWidget {
  final CommentEntity comment;
  final String videoId;
  final UserParams currentUser;
  final void Function(CommentEntity reply, String parentId)? onEditReply;

  const RepliesThread({
    super.key,
    required this.comment,
    required this.videoId,
    required this.currentUser,
    this.onEditReply,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return BlocConsumer<RepliesCubit, RepliesState>(
      listenWhen: (previous, current) {
        return previous.lastErrorMessage == null &&
            current.lastErrorMessage != null;
      },
      listener: (context, state) {
        if (state.lastErrorMessage != null) {
          context.showErrorSnackBar(message: state.lastErrorMessage!);
        }
      },
      builder: (context, state) {
        final parentId = comment.commentId;
        if (!state.isExpanded(parentId)) return const SizedBox.shrink();

        final loading = state.isLoading(parentId);
        final error = state.errorOf(parentId);
        final replies = state.repliesOf(parentId);
        final submitting = state.isSubmitting(parentId);

        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: appTheme.boarderPrimary, width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (submitting)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.w,
                          height: 12.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: appTheme.primaryColor,
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          'Posting reply…',
                          style: textTheme.labelSmall?.copyWith(
                            color: appTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (loading && replies.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: appTheme.primaryColor,
                        ),
                      ),
                    ),
                  )
                else if (error != null && replies.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            error,
                            style: textTheme.bodySmall?.copyWith(
                              color: appTheme.errorColor,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context
                              .read<RepliesCubit>()
                              .fetchReplies(parentId, force: true),
                          child: Text(
                            'Retry',
                            style: TextStyle(color: appTheme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  )
                else if (replies.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Text(
                      'No replies yet.',
                      style: textTheme.bodySmall?.copyWith(
                        color: appTheme.textSecondary,
                      ),
                    ),
                  )
                else
                  ...replies.map(
                    (reply) => CommentItemWidget(
                      comment: reply,
                      videoId: videoId,
                      currentUser: currentUser,
                      isReply: true,
                      parentId: parentId,
                      onEditReply: onEditReply,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
