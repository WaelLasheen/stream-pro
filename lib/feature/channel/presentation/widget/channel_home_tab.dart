import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_home_entity.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_home_tab_cubit/channel_home_tab_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_home_tab_cubit/channel_home_tab_state.dart';
import 'package:stream_pro/feature/channel/presentation/mappers/playlist_mapper.dart';
import 'package:stream_pro/feature/channel/presentation/mappers/video_mapper.dart';
import 'package:stream_pro/core/shared/widgets/channel/common_slivers.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class ChannelHomeTab extends StatelessWidget {
  final String channelId;
  final SliverOverlapAbsorberHandle handle;

  const ChannelHomeTab({
    super.key,
    required this.channelId,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelHomeTabCubit, ChannelHomeTabState>(
      builder: (context, state) {
        return CustomScrollView(
          key: PageStorageKey('channel_home_$channelId'),
          slivers: [
            SliverOverlapInjector(handle: handle),

            if (state is ChannelHomeTabInitialState ||
                state is ChannelHomeTabLoadingState)
              SliverShimmerList(itemBuilder: (_, _) => const VideoCardShimmer())
            else if (state is ChannelHomeTabErrorState)
              AppErrorSliver(
                message: state.message,
                onRetry: () {
                  context.read<ChannelHomeTabCubit>().fetchChannelHome(
                    channelId,
                  );
                },
                iconSize: 42.r,
              )
            else if (state is ChannelHomeTabLoadedState)
              ChannelHomeSlivers(home: state.home),
          ],
        );
      },
    );
  }
}

class ChannelHomeSlivers extends StatelessWidget {
  final ChannelHomeEntity home;

  const ChannelHomeSlivers({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    if (home.videos.isEmpty && home.playlists.isEmpty) {
      return AppEmptySliver(
        message: 'No content available in this channel yet',
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        if (home.videos.isNotEmpty) ...[
          const SliverSectionHeader(title: 'Latest videos'),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final video = home.videos[index];
                return VideoCardWidget(
                  video: video.toVideoCardData(),
                  variant: VideoCardVariant.vertical,
                  onTap: () => context.navigateTo(
                    AppRoutes.videoDetails,
                    arguments: VideoDetailsArgs(video.id),
                  ),
                );
              }, childCount: home.videos.length),
            ),
          ),
        ],
        if (home.playlists.isNotEmpty) ...[
          const SliverSectionHeader(title: 'Playlists'),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final playlist = home.playlists[index];
                return PlaylistCardWidget(
                  playlist: playlist.toVideoCardData(),
                  onTap: () {},
                );
              }, childCount: home.playlists.length),
            ),
          ),
        ],
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }
}
