import 'package:stream_pro/feature/video_details/domain/entities/related_video_entity.dart';

class RelatedVideoModel {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final int views;
  final String channelId;
  final String channelTitle;
  final String channelImageUrl;

  const RelatedVideoModel({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.channelId,
    required this.channelTitle,
    required this.channelImageUrl,
  });

  factory RelatedVideoModel.fromJson(Map<String, dynamic> json) {
    return RelatedVideoModel(
      videoId: json['videoId'] as String,
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      durationSeconds: json['durationSeconds'] as int? ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      channelId: json['channelId'] as String,
      channelTitle: json['channelTitle'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
    );
  }

  RelatedVideoEntity toEntity() {
    return RelatedVideoEntity(
      videoId: videoId,
      title: title,
      thumbnailUrl: thumbnailUrl,
      durationSeconds: durationSeconds,
      views: views,
      channelId: channelId,
      channelTitle: channelTitle,
      channelImageUrl: channelImageUrl,
    );
  }
}
