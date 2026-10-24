import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class UpdatePlaylistUseCase {
  final PlaylistRepository _repository;

  UpdatePlaylistUseCase(this._repository);

  Future<Either<Failure, void>> call(
    String playlistId, {
    String? title,
    String? description,
    bool? isPublic,
  }) {
    return _repository.updatePlaylist(
      playlistId,
      title: title,
      description: description,
      isPublic: isPublic,
    );
  }
}
