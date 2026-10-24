import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class DeletePlaylistUseCase {
  final PlaylistRepository _repository;

  DeletePlaylistUseCase(this._repository);

  Future<Either<Failure, void>> call(String playlistId) {
    return _repository.deletePlaylist(playlistId);
  }
}
