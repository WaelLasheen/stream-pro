import '../models/feed_section_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<FeedSectionModel>> getFeed();
}