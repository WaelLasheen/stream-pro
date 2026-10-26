import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_channel_entity.dart';

class WatchLaterVideoEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final int views;
  final DateTime? createdAt;
  final WatchLaterChannelEntity channel;

  const WatchLaterVideoEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.createdAt,
    required this.channel,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    thumbnailUrl,
    durationSeconds,
    views,
    createdAt,
    channel,
  ];
}
