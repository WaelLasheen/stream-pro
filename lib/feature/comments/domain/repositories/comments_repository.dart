import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
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
    String? parentId,
  });

  Future<Either<Failure, void>> updateComment({
    required String commentId,
    required String content,
    String? parentId,
  });
  Future<Either<Failure, void>> deleteComment(String commentId);
  Future<Either<Failure, List<CommentEntity>>> getReplies({
    required String commentId,
  });
}
