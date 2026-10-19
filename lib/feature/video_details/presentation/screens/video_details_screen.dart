import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/video_player/app_video_player.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_state.dart';
import 'package:stream_pro/feature/video_details/presentation/mapper/video_player_mapper.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/sliver_tab_bar_delegate.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/channel_info_widget.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comments_tab.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/related_videos_tab.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_actions_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_details_shimmer.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_header_widget.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/video_track_cubit/video_track_cubit.dart';

class VideoDetailsScreen extends StatelessWidget {
  final String videoId;
  final int initialTabIndex;

  const VideoDetailsScreen({
    super.key,
    required this.videoId,
    this.initialTabIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<VideoTrackCubit>().flushCurrentProgress();
        }
      },
      child: DefaultTabController(
        length: 2,
        initialIndex: initialTabIndex,
        child: Scaffold(
          body: BlocConsumer<VideoDetailsCubit, VideoDetailsState>(
            listener: (context, state) {
              if (state is VideoDetailsFailure) {
                context.showErrorSnackBar(message: state.message);
              }
            },
            builder: (context, state) {
              switch (state) {
                case VideoDetailsInitial():
                case VideoDetailsLoading():
                  return const VideoDetailsShimmer();
                case VideoDetailsFailure():
                  return AppErrorWidget(
                    message: state.message,
                    onRetry: () => context
                        .read<VideoDetailsCubit>()
                        .loadVideoDetails(videoId),
                  );
                case VideoDetailsSuccess():
                  {
                    final video = state.video;
                    return Column(
                      children: [
                        SafeArea(
                          bottom: false,
                          child: SizedBox(
                            width: context.screenWidth,
                            child: AppVideoPlayer(
                              data: video.toVideoPlayerData(),
                              onInitialized: () {
                                context.read<VideoTrackCubit>().startTracking(
                                  videoId: videoId,
                                  initialWatchedSeconds: 0,
                                );
                                context
                                    .read<VideoDetailsCubit>()
                                    .recordVideoView(videoId);
                              },
                              onPositionChanged: (position) {
                                context.read<VideoTrackCubit>().updatePosition(
                                  position.inSeconds,
                                );
                              },
                              onPlayStateChanged: (isPlaying) {
                                if (!isPlaying) {
                                  context.read<VideoTrackCubit>().syncProgress(
                                    force: true,
                                  );
                                }
                              },
                              onVideoCompleted: () {
                                context.read<VideoTrackCubit>().syncProgress(
                                  force: true,
                                );
                              },
                            ),
                          ),
                        ),

                        Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) {
                              return [
                                SliverOverlapAbsorber(
                                  handle:
                                      NestedScrollView.sliverOverlapAbsorberHandleFor(
                                        context,
                                      ),
                                  sliver: SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.r),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          VideoHeaderWidget(
                                            title: video.title,
                                            views: video.views,
                                            createdAt: video.createdAt,
                                            description: video.description,
                                          ),
                                          SizedBox(height: 16.h),
                                          ChannelInfoWidget(
                                            channelTitle: video.channelTitle,
                                            channelImageUrl:
                                                video.channelImageUrl,
                                            subscribersCount:
                                                video.channelSubscribersCount,
                                            isSubscribed: video.isSubscribed,
                                            channelId: video.channelId,
                                          ),
                                          SizedBox(height: 16.h),
                                          VideoActionsWidget(
                                            videoId: video.videoId,
                                            isLiked: video.isLiked,
                                            likeCount: video.likesCount,
                                            commentsCount: video.commentsCount,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate: SliverTabBarDelegate(
                                    height: 48.h,
                                    child: const TabBar(
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      tabs: [
                                        Tab(text: 'Related Videos'),
                                        Tab(text: 'Comments'),
                                      ],
                                    ),
                                  ),
                                ),
                              ];
                            },
                            body: Builder(
                              builder: (context) {
                                final handle =
                                    NestedScrollView.sliverOverlapAbsorberHandleFor(
                                      context,
                                    );
                                return TabBarView(
                                  children: [
                                    RelatedVideosTab(
                                      videoId: videoId,
                                      handle: handle,
                                    ),
                                    CommentsTab(
                                      videoId: videoId,
                                      handle: handle,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
