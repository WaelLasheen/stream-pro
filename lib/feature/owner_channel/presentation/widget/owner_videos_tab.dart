import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/channel/common_slivers.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_video_entity.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_videos_cubit/owner_videos_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_videos_cubit/owner_videos_state.dart';
import 'package:stream_pro/feature/owner_channel/presentation/mappers/owner_video_mapper.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/tab_fabs.dart';

class OwnerVideosTab extends StatelessWidget {
  final SliverOverlapAbsorberHandle handle;

  const OwnerVideosTab({super.key, required this.handle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerVideosCubit, OwnerVideosState>(
      builder: (context, state) {
        final items = state.videos?.items ?? <OwnerVideoEntity>[];

        final isLoadingInitial =
            state is OwnerVideosInitialState ||
            state is OwnerVideosLoadingState;

        final initialError = state is OwnerVideosErrorState && items.isEmpty;
        final loadMoreError =
            state is OwnerVideosErrorState && items.isNotEmpty;

        final errorMessage = state is OwnerVideosErrorState
            ? state.message
            : null;

        final isLoadingMore =
            state is OwnerVideosLoadedState && state.isLoadingMore;

        return Stack(
          children: [
            LoadMoreListener(
              onLoadMore: () {
                if (state is OwnerVideosLoadedState) {
                  context.read<OwnerVideosCubit>().loadMoreVideos();
                }
              },
              child: CustomScrollView(
                key: const PageStorageKey('owner_videos'),
                slivers: [
                  SliverOverlapInjector(handle: handle),
                  if (isLoadingInitial)
                    SliverShimmerList(
                      itemBuilder: (_, _) => const VideoCardShimmer(
                        variant: VideoCardVariant.horizontal,
                      ),
                    )
                  else if (initialError)
                    AppErrorSliver(
                      message: errorMessage ?? 'Failed to load your videos',
                      onRetry: () =>
                          context.read<OwnerVideosCubit>().fetchOwnerVideos(),
                      iconSize: 42.r,
                    )
                  else ...[
                    if (items.isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.all(12.r),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final video = items[index];

                            return Stack(
                              children: [
                                VideoCardWidget(
                                  video: video.toVideoCardData(),
                                  variant: VideoCardVariant.horizontal,
                                  onTap: () async {
                                    final refresh = await context
                                        .navigateTo<bool>(
                                          AppRoutes.editVideo,
                                          arguments: video.id,
                                        );
                                    if (refresh ?? false) {
                                      if (context.mounted) {
                                        context
                                            .read<OwnerVideosCubit>()
                                            .fetchOwnerVideos();
                                      }
                                    }
                                  },
                                ),
                                if (!video.isPublished)
                                  Positioned(
                                    top: 8.h,
                                    left: 8.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        'Draft',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }, childCount: items.length),
                        ),
                      )
                    else if (state is OwnerVideosLoadedState)
                      const AppEmptySliver(message: 'No videos yet'),

                    if (isLoadingMore)
                      const SliverLoadMoreLoader()
                    else if (loadMoreError)
                      SliverLoadMoreError(
                        message: errorMessage ?? 'Failed to load more videos',
                        onRetry: () =>
                            context.read<OwnerVideosCubit>().loadMoreVideos(),
                      ),
                  ],
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TabFab(
                iconPath: ImagePath.addVideo,
                backgroundColor: Theme.of(context).colorScheme.primary,
                iconColor: Theme.of(context).colorScheme.onPrimary,
                onTap: () async {
                  final refresh = await context.navigateTo<bool>(
                    AppRoutes.uploadVideo,
                  );
                  if (refresh ?? false) {
                    if (context.mounted) {
                      context.read<OwnerVideosCubit>().fetchOwnerVideos();
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
