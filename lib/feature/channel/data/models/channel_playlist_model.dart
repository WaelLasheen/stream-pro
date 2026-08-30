import '../../domain/entities/channel_playlist_entity.dart';

class ChannelPlaylistModel {
  final String id;
  final String title;
  final String? description;
  final String? thumbnailUrl;
  final int videosCount;

  const ChannelPlaylistModel({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailUrl,
    required this.videosCount,
  });

  factory ChannelPlaylistModel.fromJson(Map<String, dynamic> json) {
    return ChannelPlaylistModel(
      id: json['id'] as String? ?? json['playlistId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      videosCount: (json['videosCount'] as num?)?.toInt() ?? 0,
    );
  }

  ChannelPlaylistEntity toEntity() {
    return ChannelPlaylistEntity(
      id: id,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl ?? "",
      videosCount: videosCount,
    );
  }
}