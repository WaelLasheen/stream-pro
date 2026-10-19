import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_cubit.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_state.dart';
import 'package:stream_pro/feature/Likes/presentation/mapper/liked_video_mapper.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class LikedVideosScreen extends StatelessWidget {
  const LikedVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liked Videos'), centerTitle: true),
      body: BlocBuilder<LikedVideosCubit, LikedVideosState>(
        builder: (context, state) {
          switch (state) {
            case LikedVideosInitial():
            case LikedVideosLoading():
              return ShimmerList(
                itemBuilder: (_, __) => const VideoCardShimmer(
                  variant: VideoCardVariant.horizontal,
                ),
                itemCount: 5,
              );
            case LikedVideosError():
              return AppErrorWidget(
                message: state.message,
                retryIcon: Icons.refresh,
                onRetry: () =>
                    context.read<LikedVideosCubit>().fetchLikedVideos(),
              );
            case LikedVideosLoaded():
              final items = state.feed.items;

              if (items.isEmpty) {
                return const AppEmptyWidget(
                  message: 'You haven\'t liked any videos yet.',
                  icon: Icons.favorite_border,
                );
              }

              return AppRefreshIndicator(
                onRefresh: () =>
                    context.read<LikedVideosCubit>().fetchLikedVideos(),
                child: ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return VideoCardWidget(
                      video: item.toVideoCardData(),
                      variant: VideoCardVariant.horizontal,
                      onTap: () {
                        context.navigateTo(
                          AppRoutes.videoDetails,
                          arguments: VideoDetailsArgs(item.video.id),
                        );
                      },
                      onChannelTap: () {
                        context.navigateTo(
                          AppRoutes.channelDetails,
                          arguments: item.video.channel.id,
                        );
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
