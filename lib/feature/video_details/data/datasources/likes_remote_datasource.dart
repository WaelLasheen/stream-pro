import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';

abstract class LikesRemoteDataSource {
  Future<void> likeVideo(String videoId);
  Future<void> unlikeVideo(String videoId);
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
}