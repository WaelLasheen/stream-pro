import 'package:stream_pro/core/networking/api_constants.dart';
import '../../../../core/networking/api_service.dart';
import '../models/category_model.dart';
import 'category_remote_datasource.dart';

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final ApiService apiService;

  CategoryRemoteDatasourceImpl(this.apiService);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiService.get(ApiConstants.categories);

    return (response.data as List)
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
