import 'package:stream_pro/feature/Likes/domain/entities/channel_entity.dart';

class VideoEntity {
  final String id;
  final String createdAt;
  final ChannelEntity channel;
  final String title;
  final int durationSeconds;
  final String thumbnailUrl;
  final int views;

  const VideoEntity({
    required this.id,
    required this.createdAt,
    required this.channel,
    required this.title,
    required this.durationSeconds,
    required this.thumbnailUrl,
    required this.views,
  });
}
