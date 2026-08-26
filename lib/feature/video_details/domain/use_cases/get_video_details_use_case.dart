import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class GetVideoDetailsUseCase {
  final VideoDetailsRepository repository;

  GetVideoDetailsUseCase(this.repository);

  Future<Either<Failure, VideoEntity>> call(String videoId) {
    return repository.getVideoDetails(videoId);
  }
}