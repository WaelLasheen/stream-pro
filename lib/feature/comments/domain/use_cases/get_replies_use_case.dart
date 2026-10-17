import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/comment_entity.dart';
import '../repositories/comments_repository.dart';

class GetRepliesUseCase {
  final CommentsRepository repository;
  GetRepliesUseCase(this.repository);

  Future<Either<Failure, List<CommentEntity>>> call(String commentId) {
    return repository.getReplies(commentId: commentId);
  }
}