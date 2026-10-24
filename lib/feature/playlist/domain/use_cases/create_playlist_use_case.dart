import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class CreatePlaylistUseCase {
  final PlaylistRepository _repository;

  CreatePlaylistUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String title,
    String? description,
    bool isPublic = false,
  }) {
    return _repository.createPlaylist(
      title: title,
      description: description,
      isPublic: isPublic,
    );
  }
}
