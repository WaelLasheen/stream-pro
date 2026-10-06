import '../../domain/entities/paginated_search_result_entity.dart';
import 'search_video_model.dart';

class PaginatedSearchResultModel {
  final List<SearchVideoModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;

  const PaginatedSearchResultModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
  });

  factory PaginatedSearchResultModel.fromJson(Map<String, dynamic> json) {
    return PaginatedSearchResultModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => SearchVideoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      hasNextPage: (json['hasNextPage'] as bool?) ?? true,
    );
  }

  PaginatedSearchResultEntity toEntity() {
    return PaginatedSearchResultEntity(
      items: items.map((item) => item.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      hasNextPage: hasNextPage
    );
  }
}
