import 'package:stream_pro/feature/home/data/models/video_model.dart';
import '../../domain/entities/paginated_channel_videos_entity.dart';

class PaginatedChannelVideosModel {
  final List<VideoModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedChannelVideosModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory PaginatedChannelVideosModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] as List<dynamic>? ?? [];
    return PaginatedChannelVideosModel(
      items: itemsJson.map((e) => VideoModel.fromJson(e as Map<String, dynamic>)).toList(),
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
    );
  }

  PaginatedChannelVideosEntity toEntity() {
    return PaginatedChannelVideosEntity(
      items: items.map((e) => e.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
    );
  }
}