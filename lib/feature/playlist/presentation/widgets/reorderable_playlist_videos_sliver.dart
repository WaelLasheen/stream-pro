import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_video_tile.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class ReorderablePlaylistVideosSliver extends StatelessWidget {
  final List<PlaylistVideoEntity> videos;

  const ReorderablePlaylistVideosSliver({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return SliverReorderableList(
      onReorder: (oldIndex, newIndex) => context
          .read<PlaylistDetailsCubit>()
          .reorderVideos(oldIndex, newIndex),
      // The drag proxy is rendered in the overlay, where there is no Material
      // ancestor, the tiles' InkWell would assert without wrapping it.
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Material(
              elevation: Tween<double>(begin: 0, end: 8).evaluate(animation),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
              clipBehavior: Clip.antiAlias,
              child: child,
            );
          },
          child: child,
        );
      },
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return PlaylistVideoTile(
          key: ValueKey(video.videoId),
          video: video,
          isOwner: true,
          index: index,
          onTap: () => context.navigateTo(
            AppRoutes.videoDetails,
            arguments: VideoDetailsArgs(video.videoId),
          ),
          onRemove: () =>
              context.read<PlaylistDetailsCubit>().removeVideo(video.videoId),
        );
      },
    );
  }
}
