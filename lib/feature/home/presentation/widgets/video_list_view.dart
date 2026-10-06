import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/utils/extensions/app_padding.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/feature/home/domain/entities/video_entity.dart';
import 'package:stream_pro/feature/home/presentation/mappers/video_mapper.dart';

class VideoListView extends StatelessWidget {
  final List<VideoEntity> videos;
  final bool isLoadingMore;
  final Future<void> Function() onRefresh;
  final VoidCallback? onLoadMore;

  const VideoListView({
    super.key,
    required this.videos,
    this.isLoadingMore = false,
    required this.onRefresh,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LoadMoreListener(
        onLoadMore: onLoadMore,
        child: ListView.builder(
          key: const PageStorageKey<String>('home_videos_list_key'),
          padding: EdgeInsets.fromLTRB(
            16.w,
            8.h,
            16.w,
            context.bottomNavPadding,
          ),
          itemCount: videos.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= videos.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final video = videos[index];
            return VideoCardWidget(
              video: video.toVideoCardData(),
              onTap: () => context.navigateTo(
                AppRoutes.videoDetails,
                arguments: video.id,
              ),
              onChannelTap: () => context.navigateTo(
                AppRoutes.channelDetails,
                arguments: video.channel.id,
              ),
            );
          },
        ),
      ),
    );
  }
}
