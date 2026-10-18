import '../models/watch_history_model.dart';

abstract class WatchHistoryRemoteDataSource {
  Future<List<WatchHistoryModel>> getWatchHistory();

  Future<void> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  });
}
