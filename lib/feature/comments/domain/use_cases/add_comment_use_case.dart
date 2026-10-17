import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/comments_repository.dart';

class AddCommentUseCase {
  final CommentsRepository repository;
  AddCommentUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String videoId,
    required String content,
    String? parentId,
  }) {
    return repository.addComment(
      videoId: videoId,
      content: content,
      parentId: parentId,
    );
  }
}
