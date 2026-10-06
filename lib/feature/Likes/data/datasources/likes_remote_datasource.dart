import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/Likes/data/models/liked_videos_response_model.dart';

abstract class LikesRemoteDataSource {
  Future<void> likeVideo(String videoId);
  Future<void> unlikeVideo(String videoId);
  Future<LikedVideosResponseModel> getLikedVideos();
}

class LikesRemoteDataSourceImpl implements LikesRemoteDataSource {
  final ApiService apiService;

  LikesRemoteDataSourceImpl(this.apiService);

  @override
  Future<void> likeVideo(String videoId) async {
    await apiService.post(ApiConstants.likeVideo(videoId));
  }

  @override
  Future<void> unlikeVideo(String videoId) async {
    await apiService.delete(ApiConstants.likeVideo(videoId));
  }

  @override
  Future<LikedVideosResponseModel> getLikedVideos() async {
    final response = await apiService.get(ApiConstants.likedVideos);
    return LikedVideosResponseModel.fromJson(response.data);
  }
}
