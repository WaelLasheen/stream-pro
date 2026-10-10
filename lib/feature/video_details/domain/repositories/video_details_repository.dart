import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';

abstract class VideoDetailsRepository {
  Future<Either<Failure, VideoEntity>> getVideoDetails(String videoId);
  Future<Either<Failure, void>> recordVideoView(String videoId);
}
