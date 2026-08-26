import 'package:equatable/equatable.dart';
import 'channel_entity.dart';

class VideoEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int duration;
  final int views;
  final DateTime createdAt;
  final ChannelEntity channel;

  const VideoEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.views,
    required this.createdAt,
    required this.channel,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnailUrl,
        duration,
        views,
        createdAt,
        channel,
      ];
}