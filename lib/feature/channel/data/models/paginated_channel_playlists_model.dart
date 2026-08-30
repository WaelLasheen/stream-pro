import '../../domain/entities/paginated_channel_playlists_entity.dart';
import 'channel_playlist_model.dart';

class PaginatedChannelPlaylistsModel {
  final List<ChannelPlaylistModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedChannelPlaylistsModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory PaginatedChannelPlaylistsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] as List<dynamic>? ?? [];
    return PaginatedChannelPlaylistsModel(
      items: itemsJson.map((e) => ChannelPlaylistModel.fromJson(e as Map<String, dynamic>)).toList(),
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
    );
  }

  PaginatedChannelPlaylistsEntity toEntity() {
    return PaginatedChannelPlaylistsEntity(
      items: items.map((e) => e.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
    );
  }
}