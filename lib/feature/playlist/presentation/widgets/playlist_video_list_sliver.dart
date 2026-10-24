import 'package:flutter/material.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_video_tile.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class PlaylistVideoListSliver extends StatelessWidget {
  final List<PlaylistVideoEntity> videos;

  const PlaylistVideoListSliver({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final video = videos[index];
        return PlaylistVideoTile(
          key: ValueKey(video.videoId),
          video: video,
          isOwner: false,
          index: index,
          onTap: () => context.navigateTo(
            AppRoutes.videoDetails,
            arguments: VideoDetailsArgs(video.videoId),
          ),
        );
      }, childCount: videos.length),
    );
  }
}
