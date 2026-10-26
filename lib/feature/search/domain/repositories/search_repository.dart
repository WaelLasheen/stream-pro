import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/paginated_search_result_entity.dart';
import '../entities/search_suggestion_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, PaginatedSearchResultEntity>> searchVideos({
    required String query,
    String? category,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, List<SearchSuggestionEntity>>> getSuggestions(
    String query,
  );
}
