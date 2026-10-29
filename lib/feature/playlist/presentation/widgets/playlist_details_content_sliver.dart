import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/view_models/playlist_details_view.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_video_list_sliver.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/reorderable_playlist_videos_sliver.dart';
import 'package:stream_pro/generated/l10n.dart';

class PlaylistDetailsContentSliver extends StatelessWidget {
  final PlaylistDetailsView view;
  final String playlistId;
  final bool isOwner;

  const PlaylistDetailsContentSliver({
    super.key,
    required this.view,
    required this.playlistId,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    if (view.isLoading) {
      return SliverShimmerList(
        itemBuilder: (_, _) => const VideoCardShimmer(),
        itemCount: 5,
      );
    }

    if (view.hasFatalError) {
      return AppErrorSliver(
        message: view.errorMessage ?? S.current.failedToLoadPlaylist,
        onRetry: () => context.read<PlaylistDetailsCubit>().fetch(playlistId),
        iconSize: 42.r,
      );
    }

    if (view.videos.isEmpty) {
      return AppEmptySliver(
        message: S.current.playlistHasNoVideosYet,
        icon: Icons.playlist_play_outlined,
      );
    }

    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h + bottomInset),
      sliver: isOwner
          ? ReorderablePlaylistVideosSliver(videos: view.videos)
          : PlaylistVideoListSliver(videos: view.videos),
    );
  }
}
