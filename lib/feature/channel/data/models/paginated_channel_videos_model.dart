import 'package:stream_pro/feature/channel/data/models/channel_video_model.dart';
import '../../domain/entities/paginated_channel_videos_entity.dart';

class PaginatedChannelVideosModel {
  final List<ChannelVideoModel> items;
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
      items: itemsJson
          .map((e) => ChannelVideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
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
