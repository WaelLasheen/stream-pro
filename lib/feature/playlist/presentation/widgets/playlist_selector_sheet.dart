import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_state.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/create_playlist_sheet.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/create_playlist_tile.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_selector_body.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_sheet_header.dart';
import 'package:stream_pro/generated/l10n.dart';

class PlaylistSelectorSheet extends StatelessWidget {
  final String videoId;

  const PlaylistSelectorSheet({super.key, required this.videoId});

  static Future<void> show(BuildContext context, {required String videoId}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => getIt<VideoPlaylistsCubit>()..loadPlaylists(videoId),
        child: PlaylistSelectorSheet(videoId: videoId),
      ),
    );
  }

  Future<void> _createPlaylist(BuildContext context) async {
    final playlist = await CreatePlaylistSheet.show(context, videoId: videoId);
    if (playlist == null || !context.mounted) return;

    context.read<VideoPlaylistsCubit>().addCreatedPlaylist(playlist);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      constraints: BoxConstraints(maxHeight: context.screenHeight * 0.75),
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: BlocListener<VideoPlaylistsCubit, VideoPlaylistsState>(
        listener: (context, state) {
          if (state is VideoPlaylistsFailure) {
            context.showErrorSnackBar(message: state.errorMessage);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlaylistSheetHeader(title: S.current.saveToPlaylist),
            16.verticalSpace,
            CreatePlaylistTile(onTap: () => _createPlaylist(context)),
            Divider(color: appTheme.boarderPrimary, height: 1.h),
            Flexible(child: PlaylistSelectorBody(videoId: videoId)),
            SafeArea(top: false, child: 8.verticalSpace),
          ],
        ),
      ),
    );
  }
}
