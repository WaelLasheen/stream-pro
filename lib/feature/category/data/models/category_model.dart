import '../../../../core/shared/entity/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name);
  }
}
