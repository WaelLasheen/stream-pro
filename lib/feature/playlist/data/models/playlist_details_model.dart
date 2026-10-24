import '../../domain/entities/playlist_details_entity.dart';
import 'playlist_video_model.dart';

class PlaylistDetailsModel {
  final String playlistId;
  final String title;
  final String? description;
  final bool isPublic;
  final int videoCount;
  final List<PlaylistVideoModel> items;

  const PlaylistDetailsModel({
    required this.playlistId,
    required this.title,
    this.description,
    required this.isPublic,
    required this.videoCount,
    this.items = const [],
  });

  factory PlaylistDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaylistDetailsModel(
      playlistId: json['playlistId'],
      title: json['title'] ?? '',
      description: json['description'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      videoCount: json['videoCount'] ?? 0,
      items: (json['items'] as List<dynamic>)
          .map((e) => PlaylistVideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  PlaylistDetailsEntity toEntity() {
    return PlaylistDetailsEntity(
      playlistId: playlistId,
      title: title,
      description: description,
      isPublic: isPublic,
      videoCount: videoCount,
      videos: items.map((item) => item.toEntity()).toList(),
    );
  }
}
