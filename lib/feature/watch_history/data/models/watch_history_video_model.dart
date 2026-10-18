import 'package:stream_pro/feature/watch_history/domain/entities/watch_history_video_entity.dart';

class WatchHistoryVideoModel {
  final String id;
  final String title;
  final String? thumbnailUrl;
  final int durationSeconds;

  const WatchHistoryVideoModel({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    required this.durationSeconds,
  });

  factory WatchHistoryVideoModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryVideoModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      durationSeconds: json['durationSeconds'] as int? ?? 0,
    );
  }

  WatchHistoryVideoEntity toEntity() {
    return WatchHistoryVideoEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      durationSeconds: durationSeconds,
    );
  }
}
