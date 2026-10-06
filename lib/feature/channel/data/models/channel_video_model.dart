// data/models/channel_video_model.dart
import '../../domain/entities/channel_video_entity.dart';

class ChannelVideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int duration;
  final int views;
  final DateTime createdAt;
  final bool isLikedByUser;
  final bool isInWatchLater;

  const ChannelVideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.views,
    required this.createdAt,
    required this.isLikedByUser,
    required this.isInWatchLater,
  });

  factory ChannelVideoModel.fromJson(Map<String, dynamic> json) {
    return ChannelVideoModel(
      id: json['videoId'],
      title: json['videoTitle'],
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      duration: json['durationSeconds'] as int? ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      isLikedByUser: json['isLikedByUser'] as bool? ?? false,
      isInWatchLater: json['isInWatchLater'] as bool? ?? false,
    );
  }

  ChannelVideoEntity toEntity() {
    return ChannelVideoEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      duration: duration,
      views: views,
      createdAt: createdAt,
      isLikedByUser: isLikedByUser,
      isInWatchLater: isInWatchLater,
    );
  }
}
