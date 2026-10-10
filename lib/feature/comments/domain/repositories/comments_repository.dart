import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_comments_entity.dart';

abstract class CommentsRepository {
  Future<Either<Failure, PaginatedCommentsEntity>> getComments({
    required String videoId,
    required int page,
    int limit = 10,
  });

  Future<Either<Failure, String>> addComment({
    required String videoId,
    required String content,
  });

  Future<Either<Failure, void>> updateComment({
    required String commentId,
    required String content,
  });
  Future<Either<Failure, void>> deleteComment(String commentId);
}
