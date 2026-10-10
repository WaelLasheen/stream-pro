import '../../domain/entities/paginated_comments_entity.dart';
import 'comment_model.dart';

class PaginatedCommentsModel {
  final List<CommentModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedCommentsModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory PaginatedCommentsModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List? ?? [];
    return PaginatedCommentsModel(
      items: rawItems
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalPages: json['totalPages'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }

  PaginatedCommentsEntity toEntity() {
    return PaginatedCommentsEntity(
      comments: items.map((e) => e.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
    );
  }
}
