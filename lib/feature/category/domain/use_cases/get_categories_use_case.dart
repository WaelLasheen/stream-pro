import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../../core/shared/entity/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}
