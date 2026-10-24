import '../../domain/entities/playlist_video_entity.dart';

class PlaylistVideoModel {
  final String videoId;
  final String title;
  final String? thumbnailUrl;
  final int durationSeconds;
  final int views;
  final DateTime createdAt;
  final String channelId;
  final String channelTitle;
  final String? channelImageUrl;

  const PlaylistVideoModel({
    required this.videoId,
    required this.title,
    this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.createdAt,
    required this.channelId,
    required this.channelTitle,
    this.channelImageUrl,
  });

  factory PlaylistVideoModel.fromJson(Map<String, dynamic> json) {
    return PlaylistVideoModel(
      videoId: json['videoId'] ?? '',
      title: json['title'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: _parseDate(json['createdAt']),
      durationSeconds: json['durationSeconds'] ?? 0,
      views: json['views'] ?? 0,
      channelId: json['channelId'] as String,
      channelTitle: json['channelTitle'] as String,
      channelImageUrl: json['channelImageUrl'] as String?,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is! String || value.isEmpty) return DateTime.now();
    return DateTime.tryParse(value) ?? DateTime.now();
  }

  PlaylistVideoEntity toEntity() {
    return PlaylistVideoEntity(
      videoId: videoId,
      title: title,
      thumbnailUrl: thumbnailUrl,
      createdAt: createdAt,
      durationSeconds: durationSeconds,
      views: views,
      channelId: channelId,
      channelTitle: channelTitle,
      channelImageUrl: channelImageUrl,
    );
  }
}
