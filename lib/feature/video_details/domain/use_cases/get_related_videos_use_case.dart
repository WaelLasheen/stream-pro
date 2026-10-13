import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/related_video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class GetRelatedVideosUseCase {
  final VideoDetailsRepository repository;

  GetRelatedVideosUseCase(this.repository);

  Future<Either<Failure, List<RelatedVideoEntity>>> call(String videoId) {
    return repository.getRelatedVideos(videoId);
  }
}
