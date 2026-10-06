import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../../../core/error/failures/failure.dart';
import '../../domain/entities/paginated_search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedSearchResultEntity>> searchVideos({
    required String query,
    String? categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    return safeCall(() async {
      final model = await remoteDataSource.searchVideos(
        query: query,
        categoryId: categoryId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return model.toEntity();
    });
  }
}
