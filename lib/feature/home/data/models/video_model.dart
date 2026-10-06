import '../../domain/entities/video_entity.dart';
import 'channel_model.dart';

class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int duration;
  final int views;
  final DateTime createdAt;
  final ChannelModel channel;

  const VideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.views,
    required this.createdAt,
    required this.channel,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      duration: json['duration'] ?? 0,
      views: json['views'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      channel: ChannelModel.fromJson(json['channel']),
    );
  }

  VideoEntity toEntity() {
    return VideoEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      duration: duration,
      views: views,
      createdAt: createdAt,
      channel: channel.toEntity(),
    );
  }
}
