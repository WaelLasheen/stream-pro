import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_playlist_entity.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_playlists_cubit/channel_playlists_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_playlists_cubit/channel_playlists_state.dart';
import 'package:stream_pro/feature/channel/presentation/mappers/playlist_mapper.dart';
import 'package:stream_pro/core/shared/widgets/channel/common_slivers.dart';

class ChannelPlaylistsTab extends StatelessWidget {
  final String channelId;
  final SliverOverlapAbsorberHandle handle;

  const ChannelPlaylistsTab({
    super.key,
    required this.channelId,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelPlaylistsCubit, ChannelPlaylistsState>(
      builder: (context, state) {
        final items = state.playlists?.items ?? <ChannelPlaylistEntity>[];

        final isLoadingInitial =
            state is ChannelPlaylistsInitialState ||
            state is ChannelPlaylistsLoadingState;

        final initialError =
            state is ChannelPlaylistsErrorState && items.isEmpty;

        final loadMoreError =
            state is ChannelPlaylistsErrorState && items.isNotEmpty;

        final errorMessage = state is ChannelPlaylistsErrorState
            ? state.message
            : null;

        final isLoadingMore =
            state is ChannelPlaylistsLoadedState && state.isLoadingMore;

        return LoadMoreListener(
          onLoadMore: () {
            if (state is ChannelPlaylistsLoadedState) {
              context.read<ChannelPlaylistsCubit>().loadMorePlaylists(
                channelId,
              );
            }
          },
          child: CustomScrollView(
            key: PageStorageKey('channel_playlists_$channelId'),
            slivers: [
              SliverOverlapInjector(handle: handle),

              if (isLoadingInitial)
                SliverShimmerList(
                  itemBuilder: (_, _) => const PlaylistCardShimmer(),
                )
              else if (initialError)
                AppErrorSliver(
                  message: errorMessage ?? 'Failed to load channel playlists',
                  onRetry: () {
                    context.read<ChannelPlaylistsCubit>().fetchChannelPlaylists(
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
                        final playlist = items[index];

                        return PlaylistCardWidget(
                          playlist: playlist.toVideoCardData(),
                          onTap: () {},
                        );
                      }, childCount: items.length),
                    ),
                  )
                else if (state is ChannelPlaylistsLoadedState)
                  const AppEmptySliver(message: 'No playlists found'),

                if (isLoadingMore)
                  const SliverLoadMoreLoader()
                else if (loadMoreError)
                  SliverLoadMoreError(
                    message: errorMessage ?? 'Failed to load more playlists',
                    onRetry: () {
                      context.read<ChannelPlaylistsCubit>().loadMorePlaylists(
                        channelId,
                      );
                    },
                  )
                else if (state is ChannelPlaylistsLoadedState &&
                    !state.isLoadingMore &&
                    !(state.playlists?.hasNextPage ?? true) &&
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
