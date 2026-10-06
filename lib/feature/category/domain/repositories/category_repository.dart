import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../../core/shared/entity/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
