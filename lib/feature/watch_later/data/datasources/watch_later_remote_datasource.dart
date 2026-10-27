import 'package:stream_pro/feature/watch_later/data/models/watch_later_feed_model.dart';

abstract class WatchLaterRemoteDataSource {
  Future<WatchLaterFeedModel> getWatchLater({String? cursor});
  Future<void> addToWatchLater(String videoId);
  Future<void> removeFromWatchLater(String videoId);
  Future<bool> isInWatchLater(String videoId);
}
