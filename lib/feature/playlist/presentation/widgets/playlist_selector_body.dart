import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_state.dart';
import 'package:stream_pro/feature/playlist/presentation/view_models/playlist_sheet_view.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_selector_row.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_selector_row_shimmer.dart';

class PlaylistSelectorBody extends StatelessWidget {
  final String videoId;

  const PlaylistSelectorBody({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocSelector<
      VideoPlaylistsCubit,
      VideoPlaylistsState,
      PlaylistSheetView
    >(
      selector: PlaylistSheetView.from,
      builder: (context, view) {
        if (view.isLoading) {
          return ShimmerList(
            itemBuilder: (_, _) => const PlaylistSelectorRowShimmer(),
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          );
        }

        if (view.hasError && view.playlists.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(24.r),
            child: AppErrorWidget(
              message: view.errorMessage ?? 'Something went wrong',
              onRetry: () =>
                  context.read<VideoPlaylistsCubit>().loadPlaylists(videoId),
            ),
          );
        }

        if (view.playlists.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(24.r),
            child: const AppEmptyWidget(
              message: 'You have no playlists yet.',
              icon: Icons.playlist_add_outlined,
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: view.playlists.length,
          separatorBuilder: (_, __) =>
              Divider(color: appTheme.boarderPrimary, height: 1.h),
          itemBuilder: (context, index) {
            final playlist = view.playlists[index];
            return PlaylistSelectorRow(
              playlist: playlist,
              isPending: view.pendingPlaylistIds.contains(playlist.playlistId),
              onTap: () => context.read<VideoPlaylistsCubit>().togglePlaylist(
                playlist,
                videoId: videoId,
              ),
            );
          },
        );
      },
    );
  }
}
