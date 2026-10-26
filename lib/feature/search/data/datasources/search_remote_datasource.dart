import '../models/paginated_search_result_model.dart';
import '../models/search_suggestion_model.dart';

abstract class SearchRemoteDataSource {
  Future<PaginatedSearchResultModel> searchVideos({
    required String query,
    String? category,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<List<SearchSuggestionModel>> getSuggestions(String query);
}
