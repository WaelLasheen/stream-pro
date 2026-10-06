import '../../domain/entities/paginated_owner_videos_entity.dart';
import 'owner_video_model.dart';

class PaginatedOwnerVideosModel {
  final List<OwnerVideoModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedOwnerVideosModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory PaginatedOwnerVideosModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] as List<dynamic>? ?? [];
    return PaginatedOwnerVideosModel(
      items: itemsJson
          .map((e) => OwnerVideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalCount: json['totalCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
    );
  }

  PaginatedOwnerVideosEntity toEntity() {
    return PaginatedOwnerVideosEntity(
      items: items.map((e) => e.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
    );
  }
}
