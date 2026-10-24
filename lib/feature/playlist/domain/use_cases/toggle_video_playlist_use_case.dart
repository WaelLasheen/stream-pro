import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class ToggleVideoPlaylistUseCase {
  final PlaylistRepository _repository;

  ToggleVideoPlaylistUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required bool hasVideo,
    required String playlistId,
    required String videoId,
  }) {
    return hasVideo
        ? _repository.removeVideoFromPlaylist(playlistId, videoId)
        : _repository.addVideoToPlaylist(playlistId, videoId);
  }
}
