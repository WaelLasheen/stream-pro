import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../../core/shared/entity/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    return safeCall(() async {
      final models = await remoteDataSource.getCategories();
      return models.map((model) => model.toEntity()).toList();
    });
  }
}
