import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/watch_history_model.dart';
import 'watch_history_remote_datasource.dart';

class WatchHistoryRemoteDataSourceImpl implements WatchHistoryRemoteDataSource {
  final ApiService _apiService;

  WatchHistoryRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<WatchHistoryModel>> getWatchHistory() async {
    final response = await _apiService.get(ApiConstants.watchHistory);
    final rawList = response.data as List<dynamic>? ?? [];
    return rawList
        .map(
          (group) => WatchHistoryModel.fromJson(group as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  }) async {
    await _apiService.post(
      ApiConstants.trackWatchHistory,
      data: {'videoId': videoId, 'watchedSeconds': watchedSeconds},
    );
  }
}
