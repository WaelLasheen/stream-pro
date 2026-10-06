import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/Likes/data/datasources/likes_remote_datasource.dart';
import 'package:stream_pro/feature/Likes/domain/entities/liked_videos_feed_entity.dart';
import 'package:stream_pro/feature/Likes/domain/repositories/likes_repository.dart';

class LikesRepositoryImpl implements LikesRepository {
  final LikesRemoteDataSource likesRemoteDataSource;

  LikesRepositoryImpl({required this.likesRemoteDataSource});

  @override
  Future<Either<Failure, void>> likeVideo(String videoId) {
    return safeCall(() => likesRemoteDataSource.likeVideo(videoId));
  }

  @override
  Future<Either<Failure, void>> unlikeVideo(String videoId) {
    return safeCall(() => likesRemoteDataSource.unlikeVideo(videoId));
  }

  @override
  Future<Either<Failure, LikedVideosFeedEntity>> getLikedVideos() {
    return safeCall(() async {
      final likedVideosModel = await likesRemoteDataSource.getLikedVideos();
      return likedVideosModel.toEntity();
    });
  }
}
