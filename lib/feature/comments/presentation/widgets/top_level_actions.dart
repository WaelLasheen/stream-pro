import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_state.dart';
import 'package:stream_pro/generated/l10n.dart';

class TopLevelActions extends StatelessWidget {
  final CommentEntity comment;
  final void Function(CommentEntity parentComment)? onReply;

  const TopLevelActions({super.key, required this.comment, this.onReply});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;
    final actionStyle = textTheme.labelSmall?.copyWith(
      color: appTheme.grey600,
      fontWeight: FontWeight.w600,
      fontSize: 11.sp,
    );

    return Row(
      children: [
        if (comment.replyCount > 0)
          BlocBuilder<RepliesCubit, RepliesState>(
            builder: (context, state) {
              final parentId = comment.commentId;
              final expanded = state.isExpanded(parentId);
              final loading = state.isLoading(parentId);
              return InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () => context.read<RepliesCubit>().toggleExpanded(
                  parentId,
                  replyCount: comment.replyCount,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (loading)
                        SizedBox(
                          width: 10.w,
                          height: 10.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: appTheme.grey600,
                          ),
                        )
                      else ...[
                        Text(
                          expanded
                              ? S.current.hideReplies
                              : S.current.viewReplies(comment.replyCount),
                          style: actionStyle,
                        ),
                        SizedBox(width: 2.w),
                        Icon(
                          expanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 16.sp,
                          color: appTheme.grey600,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        if (comment.replyCount > 0 && onReply != null) SizedBox(width: 12.w),
        if (onReply != null)
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () => onReply!(comment),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.reply_rounded,
                    size: 14.sp,
                    color: appTheme.grey600,
                  ),
                  SizedBox(width: 4.w),
                  Text(S.current.reply, style: actionStyle),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
