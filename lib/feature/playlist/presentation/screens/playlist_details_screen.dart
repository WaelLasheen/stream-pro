import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/utils/extensions/dialog_extension.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/presentation/args/playlist_details_args.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_state.dart';
import 'package:stream_pro/feature/playlist/presentation/view_models/playlist_details_view.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/edit_playlist_sheet.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_details_content_sliver.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_details_sliver_app_bar.dart';
import 'package:stream_pro/generated/l10n.dart';

class PlaylistDetailsScreen extends StatelessWidget {
  final PlaylistDetailsArgs args;

  const PlaylistDetailsScreen({super.key, required this.args});

  Future<void> _editPlaylist(BuildContext context) async {
    final playlist = context.read<PlaylistDetailsCubit>().state.playlist;
    if (playlist == null) return;

    final result = await EditPlaylistSheet.show(context, playlist: playlist);
    if (result == null || !context.mounted) return;

    context.read<PlaylistDetailsCubit>().updatePlaylist(
      title: result.title,
      description: result.description,
      isPublic: result.isPublic,
    );
  }

  Future<void> _deletePlaylist(BuildContext context) async {
    final confirmed = await context.showDeleteConfirmationDialog(
      title: S.current.deletePlaylistTitle,
      content: S.current.deletePlaylistMessage,
    );
    if (confirmed != true || !context.mounted) return;

    context.read<PlaylistDetailsCubit>().deletePlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PlaylistDetailsCubit, PlaylistDetailsState>(
        listener: (context, state) {
          if (state is PlaylistDetailsDeleted) {
            context.showSuccessSnackBar(message: S.current.playlistDeleted);
            context.navigateBack(true);
            return;
          }
          if (state is PlaylistDetailsFailure) {
            context.showErrorSnackBar(message: state.errorMessage);
          }
        },
        child:
            BlocSelector<
              PlaylistDetailsCubit,
              PlaylistDetailsState,
              PlaylistDetailsView
            >(
              selector: PlaylistDetailsView.from,
              builder: (context, view) {
                return CustomScrollView(
                  slivers: [
                    PlaylistDetailsSliverAppBar(
                      view: view,
                      isOwner: args.isOwner,
                      onBack: () => context.navigateBack(),
                      onEdit: () => _editPlaylist(context),
                      onDelete: () => _deletePlaylist(context),
                    ),
                    PlaylistDetailsContentSliver(
                      view: view,
                      playlistId: args.playlistId,
                      isOwner: args.isOwner,
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }
}
