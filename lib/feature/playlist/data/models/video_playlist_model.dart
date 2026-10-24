import '../../domain/entities/video_playlist_entity.dart';

class VideoPlaylistModel {
  final String playlistId;
  final String title;
  final bool isPublic;
  final bool hasVideo;

  const VideoPlaylistModel({
    required this.playlistId,
    required this.title,
    required this.isPublic,
    required this.hasVideo,
  });

  factory VideoPlaylistModel.fromJson(Map<String, dynamic> json) {
    return VideoPlaylistModel(
      playlistId: json['playlistId'],
      title: json['title'] ?? '',
      isPublic: json['isPublic'] as bool? ?? false,
      hasVideo: json['hasVideo'] as bool? ?? false,
    );
  }

  VideoPlaylistEntity toEntity() {
    return VideoPlaylistEntity(
      playlistId: playlistId,
      title: title,
      isPublic: isPublic,
      hasVideo: hasVideo,
    );
  }
}
