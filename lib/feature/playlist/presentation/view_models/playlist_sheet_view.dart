import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_state.dart';

class PlaylistSheetView extends Equatable {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final List<VideoPlaylistEntity> playlists;
  final Set<String> pendingPlaylistIds;

  const PlaylistSheetView({
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
    required this.playlists,
    required this.pendingPlaylistIds,
  });

  factory PlaylistSheetView.from(VideoPlaylistsState state) {
    return PlaylistSheetView(
      isLoading:
          state is VideoPlaylistsInitial || state is VideoPlaylistsLoading,
      hasError: state is VideoPlaylistsFailure,
      errorMessage: state is VideoPlaylistsFailure ? state.errorMessage : null,
      playlists: state.playlists,
      pendingPlaylistIds: state.pendingPlaylistIds,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    hasError,
    errorMessage,
    playlists,
    pendingPlaylistIds,
  ];
}
