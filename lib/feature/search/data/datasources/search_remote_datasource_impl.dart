import '../../../../core/networking/api_service.dart';
import '../models/paginated_search_result_model.dart';
import 'search_remote_datasource.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiService apiService;

  SearchRemoteDataSourceImpl(this.apiService);

  @override
  Future<PaginatedSearchResultModel> searchVideos({
    required String query,
    String? categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'query': query,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (categoryId != null && categoryId.isNotEmpty) {
      queryParameters['category'] = categoryId;
    }

    final response = await apiService.get(
      "videos/search",
      queryParameters: queryParameters,
    );

    return PaginatedSearchResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
