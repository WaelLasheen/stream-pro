import '../models/watch_history_group_model.dart';
import '../models/watch_history_tracked_item_model.dart';

abstract class WatchHistoryRemoteDataSource {
  Future<List<WatchHistoryGroupModel>> getWatchHistory();

  Future<WatchHistoryTrackedItemModel> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  });
}