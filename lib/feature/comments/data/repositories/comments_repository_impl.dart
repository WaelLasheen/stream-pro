import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import '../../domain/entities/paginated_comments_entity.dart';
import '../../domain/repositories/comments_repository.dart';
import '../datasources/comments_remote_datasource.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;
  CommentsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedCommentsEntity>> getComments({
    required String videoId,
    required int page,
    int limit = 10,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getComments(
        videoId: videoId,
        page: page,
        limit: limit,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, String>> addComment({
    required String videoId,
    required String content,
    String? parentId,
  }) {
    return safeCall(() async {
      final commentId = await remoteDataSource.addComment(
        videoId: videoId,
        content: content,
        parentId: parentId,
      );
      return commentId;
    });
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) {
    return safeCall(() => remoteDataSource.deleteComment(commentId));
  }

  @override
  Future<Either<Failure, void>> updateComment({
    required String commentId,
    required String content,
    String? parentId,
  }) {
    return safeCall(() async {
      await remoteDataSource.updateComment(
        commentId: commentId,
        content: content,
        parentId: parentId,
      );
    });
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getReplies({
    required String commentId,
  }) {
    return safeCall(() async {
      final replies = await remoteDataSource.getReplies(commentId);
      return replies.map((e) => e.toEntity()).toList();
    });
  }
}
