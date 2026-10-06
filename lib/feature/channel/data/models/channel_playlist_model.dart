import '../../domain/entities/channel_playlist_entity.dart';

class ChannelPlaylistModel {
  final String id;
  final String title;
  final String? description;
  final List<String> thumbnails;
  final int videosCount;
  final bool isPublic;

  const ChannelPlaylistModel({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnails,
    required this.videosCount,
    required this.isPublic,
  });

  factory ChannelPlaylistModel.fromJson(Map<String, dynamic> json) {
    return ChannelPlaylistModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      videosCount: (json['videosCount'] as num?)?.toInt() ?? 0,
      isPublic: json['isPublic'] as bool? ?? false,
    );
  }

  ChannelPlaylistEntity toEntity() {
    return ChannelPlaylistEntity(
      id: id,
      title: title,
      description: description,
      thumbnails: thumbnails,
      videosCount: videosCount,
      isPublic: isPublic,
    );
  }
}
