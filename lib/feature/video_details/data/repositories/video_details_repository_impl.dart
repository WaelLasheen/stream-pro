import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/video_details/data/datasources/comments_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/datasources/likes_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/datasources/video_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comments_paginated_entity.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class VideoDetailsRepositoryImpl implements VideoDetailsRepository {
  final VideoRemoteDataSource videoRemoteDataSource;
  final LikesRemoteDataSource likesRemoteDataSource;
  final CommentsRemoteDataSource commentsRemoteDataSource;

  VideoDetailsRepositoryImpl({
    required this.videoRemoteDataSource,
    required this.likesRemoteDataSource,
    required this.commentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, VideoEntity>> getVideoDetails(String videoId) {
    return safeCall(() async {
      final model = await videoRemoteDataSource.getVideoDetails(videoId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> likeVideo(String videoId) {
    return safeCall(() => likesRemoteDataSource.likeVideo(videoId));
  }

  @override
  Future<Either<Failure, void>> unlikeVideo(String videoId) {
    return safeCall(() => likesRemoteDataSource.unlikeVideo(videoId));
  }

  @override
  Future<Either<Failure, CommentsPaginatedEntity>> getComments({
    required String videoId,
    required int page,
    required int limit,
  }) {
    return safeCall(() async {
      final response = await commentsRemoteDataSource.getComments(
        videoId: videoId,
        page: page,
        limit: limit,
      );
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, CommentEntity>> addComment({
    required String videoId,
    required String content,
  }) {
    return safeCall(() async {
      final model = await commentsRemoteDataSource.addComment(
        videoId: videoId,
        content: content,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, CommentEntity>> updateComment({
    required String commentId,
    required String content,
  }) {
    return safeCall(() async {
      final model = await commentsRemoteDataSource.updateComment(
        commentId: commentId,
        content: content,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) {
    return safeCall(() => commentsRemoteDataSource.deleteComment(commentId));
  }
}