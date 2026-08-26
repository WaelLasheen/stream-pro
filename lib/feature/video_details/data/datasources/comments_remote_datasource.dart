import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/video_details/data/models/comment_model.dart';
import 'package:stream_pro/feature/video_details/data/models/comments_response_model.dart';

abstract class CommentsRemoteDataSource {
  Future<CommentsResponseModel> getComments({
    required String videoId,
    required int page,
    required int limit,
  });
  Future<CommentModel> addComment({
    required String videoId,
    required String content,
  });
  Future<CommentModel> updateComment({
    required String commentId,
    required String content,
  });
  Future<void> deleteComment(String commentId);
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final ApiService apiService;

  CommentsRemoteDataSourceImpl(this.apiService);

  @override
  Future<CommentsResponseModel> getComments({
    required String videoId,
    required int page,
    required int limit,
  }) async {
    final response = await apiService.get(
      ApiConstants.comments(videoId),
      queryParameters: {'page': page, 'limit': limit},
    );
    return CommentsResponseModel.fromJson(response.data);
  }

  @override
  Future<CommentModel> addComment({
    required String videoId,
    required String content,
  }) async {
    final response = await apiService.post(
      ApiConstants.comments(videoId),
      data: {'content': content},
    );
    return CommentModel.fromJson(response.data);
  }

  @override
  Future<CommentModel> updateComment({
    required String commentId,
    required String content,
  }) async {
    final response = await apiService.patch(
      ApiConstants.commentById(commentId),
      data: {'content': content},
    );
    return CommentModel.fromJson(response.data);
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await apiService.delete(ApiConstants.commentById(commentId));
  }
}