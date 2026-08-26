import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class UpdateCommentUseCase {
  final VideoDetailsRepository repository;

  UpdateCommentUseCase(this.repository);

  Future<Either<Failure, CommentEntity>> call({
    required String commentId,
    required String content,
  }) {
    return repository.updateComment(commentId: commentId, content: content);
  }
}