import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/tab_fabs.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/load_more_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_state.dart.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/mappers/user_mapper.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_item_widget.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_shimmer.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_bottom_sheet/comments_bottom_sheet.dart';

class CommentsTab extends StatelessWidget {
  final String videoId;
  final SliverOverlapAbsorberHandle handle;

  const CommentsTab({super.key, required this.videoId, required this.handle});

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<CommentsCubit>()),
          BlocProvider.value(value: context.read<RepliesCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
        ],
        child: CommentBottomSheet(videoId: videoId),
      ),
    );
  }

  void _openReplySheet(BuildContext context, CommentEntity parentComment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<CommentsCubit>()),
          BlocProvider.value(value: context.read<RepliesCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
        ],
        child: CommentBottomSheet(
          videoId: videoId,
          parentId: parentComment.commentId,
          parentUserName: parentComment.userName,
        ),
      ),
    );
  }

  void _openEditSheet(
    BuildContext context, {
    CommentEntity? topLevelComment,
    CommentEntity? replyComment,
    String? replyParentId,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<CommentsCubit>()),
          BlocProvider.value(value: context.read<RepliesCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
        ],
        child: CommentBottomSheet(
          videoId: videoId,
          editingComment: topLevelComment ?? replyComment,
          editingReplyParentId: replyParentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileError) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(handle: handle),
              AppErrorSliver(
                message: profileState.message,
                onRetry: () => context.read<ProfileCubit>().fetchProfile(),
              ),
            ],
          );
        }
        final profile = profileState.profile;
        if (profile == null) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(handle: handle),
              SliverShimmerList(
                itemBuilder: (_, __) => const CommentShimmer(),
                itemCount: 5,
              ),
            ],
          );
        }
        {
          final currentUser = profile.toUserParams();
          return BlocConsumer<CommentsCubit, CommentsState>(
            listener: (context, state) {
              if (state is CommentsError) {
                context.showErrorSnackBar(message: state.message);
              }
            },

            builder: (context, state) {
              final items = state.comments?.comments ?? [];

              final isLoadingInitial =
                  state is CommentsLoading || state is CommentsInitial;
              final initialError = state is CommentsError && items.isEmpty;
              final loadMoreError = state is CommentsError && items.isNotEmpty;
              final isLoadingMore =
                  state is CommentsLoaded && state.isLoadingMore;

              return Stack(
                children: [
                  LoadMoreListener(
                    onLoadMore: () {
                      if (state is CommentsLoaded) {
                        context.read<CommentsCubit>().loadMoreComments(videoId);
                      }
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(handle: handle),
                        if (isLoadingInitial)
                          SliverShimmerList(
                            itemBuilder: (_, __) => const CommentShimmer(),
                            itemCount: 5,
                          )
                        else if (initialError)
                          AppErrorSliver(
                            message: state.message,
                            onRetry: () => context
                                .read<CommentsCubit>()
                                .fetchComments(videoId),
                          )
                        else if (items.isEmpty && !isLoadingMore)
                          const AppEmptySliver(
                            message: 'No comments yet. Be the first!',
                          )
                        else ...[
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  if (index == items.length) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return CommentItemWidget(
                                    comment: items[index],
                                    videoId: videoId,
                                    currentUser: currentUser,
                                    onReply: (parent) =>
                                        _openReplySheet(context, parent),
                                    onEditTopLevel: (comment) => _openEditSheet(
                                      context,
                                      topLevelComment: comment,
                                    ),
                                    onEditReply: (reply, parentId) =>
                                        _openEditSheet(
                                          context,
                                          replyComment: reply,
                                          replyParentId: parentId,
                                        ),
                                  );
                                },
                                childCount:
                                    items.length + (isLoadingMore ? 1 : 0),
                              ),
                            ),
                          ),
                          if (loadMoreError)
                            LoadMoreErrorSliver(
                              onRetry: () => context
                                  .read<CommentsCubit>()
                                  .loadMoreComments(videoId),
                              message: 'Failed to load more comments',
                            ),
                        ],
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TabFab(
                      iconPath: ImagePath.comment,
                      backgroundColor: appTheme.primaryColor,
                      iconColor: appTheme.onPrimary,
                      onTap: () => _openAddSheet(context),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
