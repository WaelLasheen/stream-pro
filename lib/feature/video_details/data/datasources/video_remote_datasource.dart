import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/video_details/data/models/related_video_model.dart';
import 'package:stream_pro/feature/video_details/data/models/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<VideoModel> getVideoDetails(String videoId);
  Future<void> recordVideoView(String videoId);
  Future<List<RelatedVideoModel>> getRelatedVideos(String videoId);
  Future<void> downloadVideo({
    required String videoId,
    required String savePath,
    void Function(int count, int total)? onReceiveProgress,
  });
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final ApiService apiService;

  VideoRemoteDataSourceImpl(this.apiService);

  @override
  Future<VideoModel> getVideoDetails(String videoId) async {
    final response = await apiService.get(ApiConstants.videoDetails(videoId));
    return VideoModel.fromJson(response.data);
  }

  @override
  Future<void> recordVideoView(String videoId) async {
    await apiService.post(ApiConstants.videoViews(videoId));
  }

  @override
  Future<List<RelatedVideoModel>> getRelatedVideos(String videoId) async {
    final response = await apiService.get(ApiConstants.relatedVideos(videoId));
    return (response.data as List<dynamic>)
        .map((e) => RelatedVideoModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> downloadVideo({
    required String videoId,
    required String savePath,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    await apiService.download(
      ApiConstants.downloadVideo(videoId),
      savePath,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
