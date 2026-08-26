import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/feed_section_model.dart';
import 'home_remote_datasource.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<FeedSectionModel>> getFeed() async {
    final response = await _apiService.get(ApiConstants.feed);
    final Map<String, dynamic> data = response.data;
    final List<dynamic> sections = data['sections'] as List<dynamic>? ?? [];

    return sections
        .map((json) => FeedSectionModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}