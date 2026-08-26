import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comments_paginated_entity.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';

abstract class VideoDetailsRepository {
  Future<Either<Failure, VideoEntity>> getVideoDetails(String videoId);
  Future<Either<Failure, void>> likeVideo(String videoId);
  Future<Either<Failure, void>> unlikeVideo(String videoId);
  Future<Either<Failure, CommentsPaginatedEntity>> getComments({
    required String videoId,
    required int page,
    required int limit,
  });
  Future<Either<Failure, CommentEntity>> addComment({
    required String videoId,
    required String content,
  });
  Future<Either<Failure, CommentEntity>> updateComment({
    required String commentId,
    required String content,
  });
  Future<Either<Failure, void>> deleteComment(String commentId);
}