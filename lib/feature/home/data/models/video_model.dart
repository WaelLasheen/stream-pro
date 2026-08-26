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
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      channel: ChannelModel.fromJson(
        json['channel'] as Map<String, dynamic>? ?? {},
      ),
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