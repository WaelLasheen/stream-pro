import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class ReorderPlaylistVideosUseCase {
  final PlaylistRepository _repository;

  ReorderPlaylistVideosUseCase(this._repository);

  Future<Either<Failure, void>> call(String playlistId, List<String> videoIds) {
    return _repository.reorderPlaylistVideos(playlistId, videoIds);
  }
}
