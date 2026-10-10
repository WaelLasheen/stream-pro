import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/comments/data/datasources/comments_remote_datasource.dart';
import 'package:stream_pro/feature/comments/data/models/paginated_comments_model.dart';

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final ApiService apiService;

  CommentsRemoteDataSourceImpl(this.apiService);

  @override
  Future<PaginatedCommentsModel> getComments({
    required String videoId,
    required int page,
    required int limit,
  }) async {
    final response = await apiService.get(
      ApiConstants.videoComments(videoId),
      queryParameters: {'page': page, 'limit': limit},
    );
    return PaginatedCommentsModel.fromJson(response.data);
  }

  @override
  Future<String> addComment({
    required String videoId,
    required String content,
  }) async {
    final response = await apiService.post(
      ApiConstants.videoComments(videoId),
      data: {'content': content},
    );
    return response.data['commentId'];
  }

  @override
  Future<void> updateComment({
    required String commentId,
    required String content,
  }) async {
    await apiService.patch(
      ApiConstants.editComment(commentId),
      data: {'content': content},
    );
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await apiService.delete(ApiConstants.editComment(commentId));
  }
}
