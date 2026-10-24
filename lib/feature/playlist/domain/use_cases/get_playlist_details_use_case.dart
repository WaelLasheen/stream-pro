import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class GetPlaylistDetailsUseCase {
  final PlaylistRepository _repository;

  GetPlaylistDetailsUseCase(this._repository);

  Future<Either<Failure, PlaylistDetailsEntity>> call(String playlistId) {
    return _repository.getPlaylistDetails(playlistId);
  }
}
