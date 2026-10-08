import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/video_player/app_video_player.dart';
import 'package:stream_pro/core/shared/widgets/video_player/video_player_data.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_state.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/channel_info_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/comments_section_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_actions_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_details_shimmer.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_header_widget.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/video_track_cubit/video_track_cubit.dart';

class VideoDetailsScreen extends StatelessWidget {
  final String videoId;

  const VideoDetailsScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Flush watch progress immediately on pop/back press
          context.read<VideoTrackCubit>().flushCurrentProgress();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<VideoDetailsCubit, VideoDetailsState>(
            listener: (context, state) {
              if (state is VideoDetailsFailure) {
                context.showErrorSnackBar(message: state.errorMessage);
              } else if (state is VideoDetailsSuccess) {
                context.read<VideoCommentsCubit>().fetchComments(videoId);
              }
            },
            builder: (context, state) {
              if (state is VideoDetailsLoading ||
                  state is VideoDetailsInitial) {
                return const VideoDetailsShimmer();
              } else if (state is VideoDetailsFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<VideoDetailsCubit>().loadVideoDetails(
                            videoId,
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is VideoDetailsSuccess) {
                final video = state.video;

                return LoadMoreListener(
                  onLoadMore: () {
                    context.read<VideoCommentsCubit>().fetchMoreComments(
                      videoId,
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppVideoPlayer(
                          data: VideoPlayerData(
                            videoUrl: video.hlsUrl,
                            posterUrl: video.thumbnailUrl,
                            title: video.title,
                            autoPlay: true,
                          ),
                          onInitialized: () {
                            // Start tracking once the player is ready
                            context.read<VideoTrackCubit>().startTracking(
                              videoId: videoId,
                              initialWatchedSeconds: 0,
                            );
                          },
                          onPositionChanged: (position) {
                            // Keep cubit updated with current position continuously
                            context.read<VideoTrackCubit>().updatePosition(
                              position.inSeconds,
                            );
                          },
                          onPlayStateChanged: (isPlaying) {
                            // Sync progress immediately when user pauses
                            if (!isPlaying) {
                              context.read<VideoTrackCubit>().syncProgress(
                                force: true,
                              );
                            }
                          },
                          onVideoCompleted: () {
                            // Sync progress immediately when video ends
                            context.read<VideoTrackCubit>().syncProgress(
                              force: true,
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                channelImageUrl: video.channelImageUrl,
                                subscribersCount: video.channelSubscribersCount,
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
                              SizedBox(height: 24.h),
                              const Divider(),
                              SizedBox(height: 12.h),
                              CommentsSectionWidget(videoId: video.videoId),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
