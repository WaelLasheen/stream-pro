import 'package:equatable/equatable.dart';

class WatchHistoryTrackedItemEntity extends Equatable {
  final String id;
  final String userId;
  final String videoId;
  final String channelId;
  final int watchedSeconds;
  final int videoDuration;
  final double completionRate;
  final int watchCount;
  final String lastWatchedAt;
  final String createdAt;

  const WatchHistoryTrackedItemEntity({
    required this.id,
    required this.userId,
    required this.videoId,
    required this.channelId,
    required this.watchedSeconds,
    required this.videoDuration,
    required this.completionRate,
    required this.watchCount,
    required this.lastWatchedAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    videoId,
    channelId,
    watchedSeconds,
    videoDuration,
    completionRate,
    watchCount,
    lastWatchedAt,
    createdAt,
  ];
}
