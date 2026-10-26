import 'package:stream_pro/core/networking/api_constants.dart';

import '../../../../core/networking/api_service.dart';
import '../models/paginated_search_result_model.dart';
import '../models/search_suggestion_model.dart';
import 'search_remote_datasource.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiService apiService;

  SearchRemoteDataSourceImpl(this.apiService);

  @override
  Future<PaginatedSearchResultModel> searchVideos({
    required String query,
    String? category,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'query': query,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (category != null && category.isNotEmpty) {
      queryParameters['category'] = category;
    }

    final response = await apiService.get(
      ApiConstants.videoSearch,
      queryParameters: queryParameters,
    );

    return PaginatedSearchResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<SearchSuggestionModel>> getSuggestions(String query) async {
    final response = await apiService.get(
      ApiConstants.searchSuggestions,
      queryParameters: {'query': query},
    );

    return SearchSuggestionModel.listFromResponse(
      response.data as Map<String, dynamic>,
    );
  }
}
