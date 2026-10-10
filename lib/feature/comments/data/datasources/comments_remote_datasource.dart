import 'package:stream_pro/feature/comments/data/models/paginated_comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<PaginatedCommentsModel> getComments({
    required String videoId,
    required int page,
    required int limit,
  });
  Future<String> addComment({required String videoId, required String content});
  Future<void> updateComment({
    required String commentId,
    required String content,
  });
  Future<void> deleteComment(String commentId);
}
