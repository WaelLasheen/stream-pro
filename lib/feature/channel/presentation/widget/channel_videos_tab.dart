import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_video_entity.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_videos_cubit/channel_videos_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_videos_cubit/channel_videos_state.dart';
import 'package:stream_pro/feature/channel/presentation/mappers/video_mapper.dart';
import 'package:stream_pro/core/shared/widgets/channel/common_slivers.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class ChannelVideosTab extends StatelessWidget {
  final String channelId;
  final SliverOverlapAbsorberHandle handle;

  const ChannelVideosTab({
    super.key,
    required this.channelId,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      builder: (context, state) {
        final items = state.videos?.items ?? <ChannelVideoEntity>[];

        final isLoadingInitial =
            state is ChannelVideosInitialState ||
            state is ChannelVideosLoadingState;

        final initialError = state is ChannelVideosErrorState && items.isEmpty;
        final loadMoreError =
            state is ChannelVideosErrorState && items.isNotEmpty;

        final errorMessage = state is ChannelVideosErrorState
            ? state.message
            : null;

        final isLoadingMore =
            state is ChannelVideosLoadedState && state.isLoadingMore;

        return LoadMoreListener(
          onLoadMore: () {
            if (state is ChannelVideosLoadedState) {
              context.read<ChannelVideosCubit>().loadMoreVideos(channelId);
            }
          },
          child: CustomScrollView(
            key: PageStorageKey('channel_videos_$channelId'),
            slivers: [
              SliverOverlapInjector(handle: handle),
              if (isLoadingInitial)
                SliverShimmerList(
                  itemBuilder: (_, _) => const VideoCardShimmer(),
                )
              else if (initialError)
                AppErrorSliver(
                  message: errorMessage ?? 'Failed to load channel videos',
                  onRetry: () {
                    context.read<ChannelVideosCubit>().fetchChannelVideos(
                      channelId,
                    );
                  },
                  iconSize: 42.r,
                )
              else ...[
                if (items.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.all(12.r),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final video = items[index];

                        return VideoCardWidget(
                          video: video.toVideoCardData(),
                          variant: VideoCardVariant.vertical,
                          onTap: () => context.navigateTo(
                            AppRoutes.videoDetails,
                            arguments: VideoDetailsArgs(video.id),
                          ),
                        );
                      }, childCount: items.length),
                    ),
                  )
                else if (state is ChannelVideosLoadedState)
                  const AppEmptySliver(message: 'No videos found'),

                if (isLoadingMore)
                  const SliverLoadMoreLoader()
                else if (loadMoreError)
                  SliverLoadMoreError(
                    message: errorMessage ?? 'Failed to load more videos',
                    onRetry: () {
                      context.read<ChannelVideosCubit>().loadMoreVideos(
                        channelId,
                      );
                    },
                  )
                else if (state is ChannelVideosLoadedState &&
                    !state.isLoadingMore &&
                    !(state.videos?.hasNextPage ?? true) &&
                    items.isNotEmpty)
                  const SliverEndOfList(),
              ],
            ],
          ),
        );
      },
    );
  }
}
