import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/watch_later/data/datasources/watch_later_remote_datasource.dart';
import 'package:stream_pro/feature/watch_later/data/models/watch_later_feed_model.dart';

class WatchLaterRemoteDataSourceImpl implements WatchLaterRemoteDataSource {
  final ApiService apiService;

  WatchLaterRemoteDataSourceImpl(this.apiService);

  @override
  Future<WatchLaterFeedModel> getWatchLater({String? cursor}) async {
    final response = await apiService.get(
      ApiConstants.watchLaters,
      queryParameters: {
        if (cursor != null && cursor.isNotEmpty) 'cursor': cursor,
      },
    );
    return WatchLaterFeedModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> addToWatchLater(String videoId) async {
    await apiService.post(ApiConstants.watchLaters, data: {'videoId': videoId});
  }

  @override
  Future<void> removeFromWatchLater(String videoId) async {
    await apiService.delete(ApiConstants.watchLaterById(videoId));
  }

  @override
  Future<bool> isInWatchLater(String videoId) async {
    final response = await apiService.get(
      ApiConstants.watchLaterStatus(videoId),
    );
    final data = response.data as Map<String, dynamic>;
    return data['isInWatchLater'] as bool? ?? false;
  }
}
