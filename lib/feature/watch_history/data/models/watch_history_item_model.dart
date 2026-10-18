import 'package:stream_pro/feature/watch_history/data/models/watch_history_channel_model.dart';
import 'package:stream_pro/feature/watch_history/data/models/watch_history_video_model.dart';
import 'package:stream_pro/feature/watch_history/domain/entities/watch_history_item_entity.dart';

class WatchHistoryItemModel {
  final String id;
  final WatchHistoryVideoModel video;
  final int watchedSeconds;
  final int videoDuration;
  final double completionRate;
  final String lastWatchedAt;
  final WatchHistoryChannelModel channel;

  const WatchHistoryItemModel({
    required this.id,
    required this.video,
    required this.watchedSeconds,
    required this.videoDuration,
    required this.completionRate,
    required this.lastWatchedAt,
    required this.channel,
  });

  factory WatchHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryItemModel(
      id: json['id'] as String? ?? '',
      video: WatchHistoryVideoModel.fromJson(
        json['video'] as Map<String, dynamic>? ?? {},
      ),
      watchedSeconds: json['watchedSeconds'] as int? ?? 0,
      videoDuration: json['videoDuration'] as int? ?? 0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
      lastWatchedAt: json['lastWatchedAt'] as String? ?? '',
      channel: WatchHistoryChannelModel.fromJson(
        json['channel'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  WatchHistoryItemEntity toEntity() {
    return WatchHistoryItemEntity(
      id: id,
      video: video.toEntity(),
      watchedSeconds: watchedSeconds,
      videoDuration: videoDuration,
      completionRate: completionRate,
      lastWatchedAt: lastWatchedAt,
      channel: channel.toEntity(),
    );
  }
}
