import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/video_model.dart';
import 'home_remote_datasource.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<VideoModel>> getFeed({List<String> excludeIds = const []}) async {
    final response = await _apiService.get(
      ApiConstants.feed,
      queryParameters: {
        if (excludeIds.isNotEmpty) 'excludeIds': excludeIds.join(','),
      },
    );

    final List<dynamic> videos = response.data as List<dynamic>? ?? [];

    return videos
        .map((json) => VideoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
