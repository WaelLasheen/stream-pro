import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/Likes/domain/entities/liked_videos_feed_entity.dart';

abstract class LikesRepository {
  Future<Either<Failure, void>> likeVideo(String videoId);
  Future<Either<Failure, void>> unlikeVideo(String videoId);
  Future<Either<Failure, LikedVideosFeedEntity>> getLikedVideos();
}
