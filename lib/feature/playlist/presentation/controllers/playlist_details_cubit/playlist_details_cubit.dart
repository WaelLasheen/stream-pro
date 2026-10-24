import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/delete_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/get_playlist_details_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/reorder_playlist_videos_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/toggle_video_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/update_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_state.dart';

class PlaylistDetailsCubit extends Cubit<PlaylistDetailsState> {
  final GetPlaylistDetailsUseCase getPlaylistDetailsUseCase;
  final UpdatePlaylistUseCase updatePlaylistUseCase;
  final DeletePlaylistUseCase deletePlaylistUseCase;
  final ToggleVideoPlaylistUseCase toggleVideoPlaylistUseCase;
  final ReorderPlaylistVideosUseCase reorderPlaylistVideosUseCase;

  PlaylistDetailsCubit({
    required this.getPlaylistDetailsUseCase,
    required this.updatePlaylistUseCase,
    required this.deletePlaylistUseCase,
    required this.toggleVideoPlaylistUseCase,
    required this.reorderPlaylistVideosUseCase,
  }) : super(PlaylistDetailsInitial());

  Future<void> fetch(String playlistId) async {
    emit(PlaylistDetailsLoading());

    final result = await getPlaylistDetailsUseCase(playlistId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(PlaylistDetailsFailure(errorMessage: failure.message)),
      (playlist) => emit(PlaylistDetailsLoaded(playlist: playlist)),
    );
  }

  Future<void> removeVideo(String videoId) async {
    final currentPlaylist = state.playlist;
    if (currentPlaylist == null) return;

    final optimistic = currentPlaylist.videos
        .where((video) => video.videoId != videoId)
        .toList();

    emit(
      PlaylistDetailsLoaded(
        playlist: currentPlaylist.copyWith(
          videos: optimistic,
          videoCount: currentPlaylist.videoCount - 1,
        ),
      ),
    );

    final result = await toggleVideoPlaylistUseCase(
      playlistId: currentPlaylist.playlistId,
      videoId: videoId,
      hasVideo: true,
    );
    if (isClosed) return;

    result.fold((failure) {
      emit(
        PlaylistDetailsFailure(
          playlist: currentPlaylist,
          errorMessage: failure.message,
        ),
      );
    }, (_) {});
  }

  Future<void> reorderVideos(int oldIndex, int newIndex) async {
    final currentPlaylist = state.playlist;
    if (currentPlaylist == null) return;
    final videosLength = currentPlaylist.videos.length;
    if (oldIndex < 0 || oldIndex >= videosLength) return;

    var target = newIndex;
    if (target > oldIndex) target -= 1;
    target = target.clamp(0, videosLength - 1);

    final reordered = List<PlaylistVideoEntity>.from(currentPlaylist.videos);
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(target, moved);

    emit(
      PlaylistDetailsLoaded(
        playlist: currentPlaylist.copyWith(videos: reordered),
      ),
    );

    final result = await reorderPlaylistVideosUseCase(
      currentPlaylist.playlistId,
      reordered.map((video) => video.videoId).toList(),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        PlaylistDetailsFailure(
          playlist: currentPlaylist,
          errorMessage: failure.message,
        ),
      ),
      (_) {},
    );
  }

  Future<void> updatePlaylist({
    String? title,
    String? description,
    bool? isPublic,
  }) async {
    final currentPlaylist = state.playlist;
    if (currentPlaylist == null) return;

    final optimistic = currentPlaylist.copyWith(
      title: title,
      description: description,
      isPublic: isPublic,
    );

    emit(PlaylistDetailsLoaded(playlist: optimistic));

    final result = await updatePlaylistUseCase(
      currentPlaylist.playlistId,
      title: title,
      description: description,
      isPublic: isPublic,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        PlaylistDetailsFailure(
          playlist: currentPlaylist,
          errorMessage: failure.message,
        ),
      ),
      (_) {},
    );
  }

  Future<void> deletePlaylist() async {
    final currentPlaylist = state.playlist;
    if (currentPlaylist == null) return;

    final result = await deletePlaylistUseCase(currentPlaylist.playlistId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        PlaylistDetailsFailure(
          playlist: currentPlaylist,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(PlaylistDetailsDeleted()),
    );
  }
}
