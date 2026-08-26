import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comments_paginated_entity.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class GetCommentsUseCase {
  final VideoDetailsRepository repository;

  GetCommentsUseCase(this.repository);

  Future<Either<Failure, CommentsPaginatedEntity>> call({
    required String videoId,
    required int page,
    int limit = 10,
  }) {
    return repository.getComments(
      videoId: videoId,
      page: page,
      limit: limit,
    );
  }
}