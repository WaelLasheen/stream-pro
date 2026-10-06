import 'package:stream_pro/feature/Likes/data/models/channel_model.dart';
import 'package:stream_pro/feature/Likes/domain/entities/video_entity.dart';

class VideoModel {
  final String id;
  final String createdAt;
  final ChannelModel channel;
  final String title;
  final int durationSeconds;
  final String thumbnailUrl;
  final int views;

  const VideoModel({
    required this.id,
    required this.createdAt,
    required this.channel,
    required this.title,
    required this.durationSeconds,
    required this.thumbnailUrl,
    required this.views,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      channel: ChannelModel.fromJson(
        json['channel'] as Map<String, dynamic>? ?? {},
      ),
      title: json['title'] as String? ?? '',
      durationSeconds: json['durationSeconds'] as int? ?? 0,
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      views: json['views'] as int? ?? 0,
    );
  }

  VideoEntity toEntity() {
    return VideoEntity(
      id: id,
      createdAt: createdAt,
      channel: channel.toEntity(),
      title: title,
      durationSeconds: durationSeconds,
      thumbnailUrl: thumbnailUrl,
      views: views,
    );
  }
}
