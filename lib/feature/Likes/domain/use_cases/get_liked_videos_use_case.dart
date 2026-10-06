import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/Likes/domain/entities/liked_videos_feed_entity.dart';
import 'package:stream_pro/feature/Likes/domain/repositories/likes_repository.dart';

class GetLikedVideosUseCase {
  final LikesRepository repository;

  GetLikedVideosUseCase(this.repository);

  Future<Either<Failure, LikedVideosFeedEntity>> call() {
    return repository.getLikedVideos();
  }
}
