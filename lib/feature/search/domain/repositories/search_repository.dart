import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/paginated_search_result_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, PaginatedSearchResultEntity>> searchVideos({
    required String query,
    String? categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  });
}
