import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/Likes/domain/repositories/likes_repository.dart';

class ToggleLikeUseCase {
  final LikesRepository repository;

  ToggleLikeUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String videoId,
    required bool isCurrentlyLiked,
  }) {
    if (isCurrentlyLiked) {
      return repository.unlikeVideo(videoId);
    } else {
      return repository.likeVideo(videoId);
    }
  }
}
