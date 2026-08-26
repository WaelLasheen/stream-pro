import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_state.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_likes_cubit/video_likes_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/channel_info_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/comments_section_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_actions_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_details_shimmer.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_header_widget.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/video_player_widget.dart';

class VideoDetailsScreen extends StatelessWidget {
  final String videoId;

  const VideoDetailsScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<VideoDetailsCubit, VideoDetailsState>(
          listener: (context, state) {
            if (state is VideoDetailsFailure) {
              context.showErrorSnackBar(message: state.errorMessage);
            } else if (state is VideoDetailsSuccess) {
              context.read<VideoLikesCubit>().init(
                isLiked: state.video.isLiked,
                likesCount: state.video.likesCount,
              );
            }
          },
          builder: (context, state) {
            if (state is VideoDetailsLoading || state is VideoDetailsInitial) {
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

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VideoPlayerWidget(
                      videoUrl: video.videoUrl,
                      thumbnailUrl: video.thumbnailUrl,
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
                          ),
                          SizedBox(height: 16.h),
                          VideoActionsWidget(
                            videoId: video.videoId,
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
