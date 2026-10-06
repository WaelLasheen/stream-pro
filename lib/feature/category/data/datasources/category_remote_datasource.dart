import '../models/category_model.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
}
