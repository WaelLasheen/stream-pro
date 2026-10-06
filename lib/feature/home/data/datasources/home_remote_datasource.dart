import '../models/video_model.dart';

abstract class HomeRemoteDataSource {
  /// [excludeIds] are the ids of videos already loaded on the client, so the
  /// server can skip them and return the next batch instead of repeats.
  Future<List<VideoModel>> getFeed({List<String> excludeIds = const []});
}
