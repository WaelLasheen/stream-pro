import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class ToggleLikeUseCase {
  final VideoDetailsRepository repository;

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