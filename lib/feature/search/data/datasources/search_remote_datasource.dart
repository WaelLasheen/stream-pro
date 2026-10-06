import '../models/paginated_search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<PaginatedSearchResultModel> searchVideos({
    required String query,
    String? categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  });
}