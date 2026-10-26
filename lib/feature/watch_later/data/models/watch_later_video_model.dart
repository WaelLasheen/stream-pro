import 'package:stream_pro/feature/watch_later/data/models/watch_later_channel_model.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_video_entity.dart';

class WatchLaterVideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final int views;
  final DateTime? createdAt;
  final WatchLaterChannelModel channel;

  const WatchLaterVideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.createdAt,
    required this.channel,
  });

  factory WatchLaterVideoModel.fromJson(Map<String, dynamic> json) {
    return WatchLaterVideoModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      channel: WatchLaterChannelModel.fromJson(
        json['channel'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  WatchLaterVideoEntity toEntity() {
    return WatchLaterVideoEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      durationSeconds: durationSeconds,
      views: views,
      createdAt: createdAt,
      channel: channel.toEntity(),
    );
  }
}
