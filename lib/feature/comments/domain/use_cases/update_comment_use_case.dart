import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/comments/domain/repositories/comments_repository.dart';

class UpdateCommentUseCase {
  final CommentsRepository repository;

  UpdateCommentUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String commentId,
    required String content,
    String? parentId,
  }) {
    return repository.updateComment(
      commentId: commentId,
      content: content,
      parentId: parentId,
    );
  }
}
