import '../../domain/entities/watch_history_tracked_item_entity.dart';

class WatchHistoryTrackedItemModel {
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

  const WatchHistoryTrackedItemModel({
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

  factory WatchHistoryTrackedItemModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryTrackedItemModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      videoId: json['videoId'] as String? ?? '',
      channelId: json['channelId'] as String? ?? '',
      watchedSeconds: json['watchedSeconds'] as int? ?? 0,
      videoDuration: json['videoDuration'] as int? ?? 0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
      watchCount: json['watchCount'] as int? ?? 0,
      lastWatchedAt: json['lastWatchedAt'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  WatchHistoryTrackedItemEntity toEntity() {
    return WatchHistoryTrackedItemEntity(
      id: id,
      userId: userId,
      videoId: videoId,
      channelId: channelId,
      watchedSeconds: watchedSeconds,
      videoDuration: videoDuration,
      completionRate: completionRate,
      watchCount: watchCount,
      lastWatchedAt: lastWatchedAt,
      createdAt: createdAt,
    );
  }
}