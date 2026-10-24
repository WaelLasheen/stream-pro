import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class GetPlaylistsForVideoUseCase {
  final PlaylistRepository _repository;

  GetPlaylistsForVideoUseCase(this._repository);

  Future<Either<Failure, List<VideoPlaylistEntity>>> call(String videoId) {
    return _repository.getPlaylistsForVideo(videoId);
  }
}
