import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/video_details/data/models/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<VideoModel> getVideoDetails(String videoId);
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final ApiService apiService;

  VideoRemoteDataSourceImpl(this.apiService);

  @override
  Future<VideoModel> getVideoDetails(String videoId) async {
    final response = await apiService.get(ApiConstants.videoDetails(videoId));
    return VideoModel.fromJson(response.data);
  }
}