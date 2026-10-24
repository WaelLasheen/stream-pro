import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/get_playlists_for_video_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/toggle_video_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_state.dart';

class VideoPlaylistsCubit extends Cubit<VideoPlaylistsState> {
  final GetPlaylistsForVideoUseCase getPlaylistsForVideoUseCase;
  final ToggleVideoPlaylistUseCase toggleVideoPlaylistUseCase;

  VideoPlaylistsCubit({
    required this.getPlaylistsForVideoUseCase,
    required this.toggleVideoPlaylistUseCase,
  }) : super(const VideoPlaylistsInitial());

  Future<void> loadPlaylists(String videoId) async {
    emit(const VideoPlaylistsLoading());

    final result = await getPlaylistsForVideoUseCase(videoId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(VideoPlaylistsFailure(errorMessage: failure.message)),
      (videoPlaylist) => emit(VideoPlaylistsLoaded(playlists: videoPlaylist)),
    );
  }

  Future<void> togglePlaylist(
    VideoPlaylistEntity playlist, {
    required String videoId,
  }) async {
    final currentPlaylists = state.playlists;
    final currentPending = state.pendingPlaylistIds;
    if (currentPlaylists.isEmpty ||
        currentPending.contains(playlist.playlistId)) {
      return;
    }

    final optimistic = playlist.copyWith(hasVideo: !playlist.hasVideo);

    emit(
      VideoPlaylistsLoaded(
        playlists: currentPlaylists
            .map(
              (item) =>
                  item.playlistId == playlist.playlistId ? optimistic : item,
            )
            .toList(),
        pendingPlaylistIds: {...currentPending, playlist.playlistId},
      ),
    );

    final result = await toggleVideoPlaylistUseCase(
      hasVideo: playlist.hasVideo,
      playlistId: playlist.playlistId,
      videoId: videoId,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        VideoPlaylistsFailure(
          errorMessage: failure.message,
          playlists: currentPlaylists,
          pendingPlaylistIds: currentPending,
        ),
      ),
      (_) => emit(
        VideoPlaylistsLoaded(
          playlists: state.playlists,
          pendingPlaylistIds: currentPending,
        ),
      ),
    );
  }

  void addCreatedPlaylist(VideoPlaylistEntity playlist) {
    if (state.playlists.any((item) => item.playlistId == playlist.playlistId)) {
      return;
    }

    emit(
      VideoPlaylistsLoaded(
        playlists: [...state.playlists, playlist],
        pendingPlaylistIds: state.pendingPlaylistIds,
      ),
    );
  }
}
