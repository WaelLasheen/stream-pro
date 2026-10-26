import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/paginated_search_result_entity.dart';
import '../repositories/search_repository.dart';

class SearchVideosParams {
  final String query;
  final String? category;
  final int pageNumber;
  final int pageSize;

  const SearchVideosParams({
    required this.query,
    this.category,
    this.pageNumber = 1,
    this.pageSize = 10,
  });
}

class SearchVideosUseCase {
  final SearchRepository repository;

  SearchVideosUseCase(this.repository);

  Future<Either<Failure, PaginatedSearchResultEntity>> call(SearchVideosParams params) {
    return repository.searchVideos(
      query: params.query,
      category: params.category,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}