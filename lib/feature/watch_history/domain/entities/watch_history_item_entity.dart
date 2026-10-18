import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_history/domain/entities/watch_history_channel_entity.dart';
import 'package:stream_pro/feature/watch_history/domain/entities/watch_history_video_entity.dart';

class WatchHistoryItemEntity extends Equatable {
  final String id;
  final WatchHistoryVideoEntity video;
  final int watchedSeconds;
  final int videoDuration;
  final double completionRate;
  final String lastWatchedAt;
  final WatchHistoryChannelEntity channel;

  const WatchHistoryItemEntity({
    required this.id,
    required this.video,
    required this.watchedSeconds,
    required this.videoDuration,
    required this.completionRate,
    required this.lastWatchedAt,
    required this.channel,
  });

  WatchHistoryItemEntity copyWith({
    String? id,
    WatchHistoryVideoEntity? video,
    int? watchedSeconds,
    int? videoDuration,
    double? completionRate,
    String? lastWatchedAt,
    WatchHistoryChannelEntity? channel,
  }) {
    return WatchHistoryItemEntity(
      id: id ?? this.id,
      video: video ?? this.video,
      watchedSeconds: watchedSeconds ?? this.watchedSeconds,
      videoDuration: videoDuration ?? this.videoDuration,
      completionRate: completionRate ?? this.completionRate,
      lastWatchedAt: lastWatchedAt ?? this.lastWatchedAt,
      channel: channel ?? this.channel,
    );
  }

  @override
  List<Object?> get props => [
    id,
    video,
    watchedSeconds,
    videoDuration,
    completionRate,
    lastWatchedAt,
    channel,
  ];
}
