import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/watch_history_group_model.dart';
import '../models/watch_history_tracked_item_model.dart';
import 'watch_history_remote_datasource.dart';

class WatchHistoryRemoteDataSourceImpl implements WatchHistoryRemoteDataSource {
  final ApiService _apiService;

  WatchHistoryRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<WatchHistoryGroupModel>> getWatchHistory() async {
    final response = await _apiService.get(ApiConstants.watchHistory);
    final rawList = response.data as List<dynamic>? ?? [];
    return rawList
        .map((group) => WatchHistoryGroupModel.fromJson(group as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WatchHistoryTrackedItemModel> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  }) async {
    final response = await _apiService.post(
      ApiConstants.trackWatchHistory,
      data: {
        'videoId': videoId,
        'watchedSeconds': watchedSeconds,
      },
    );
    return WatchHistoryTrackedItemModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}