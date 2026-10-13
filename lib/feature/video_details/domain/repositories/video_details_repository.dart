import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/related_video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';

abstract class VideoDetailsRepository {
  Future<Either<Failure, VideoEntity>> getVideoDetails(String videoId);
  Future<Either<Failure, void>> recordVideoView(String videoId);
  Future<Either<Failure, List<RelatedVideoEntity>>> getRelatedVideos(
    String videoId,
  );
  Future<Either<Failure, void>> downloadVideo({
    required String videoId,
    void Function(int count, int total)? onReceiveProgress,
  });
}
