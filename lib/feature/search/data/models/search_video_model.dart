import '../../domain/entities/search_video_entity.dart';

class SearchVideoModel {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final int views;
  final String channelId;
  final String channelName;
  final String channelProfileImageUrl;
  final String updatedAt;

  const SearchVideoModel({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.channelId,
    required this.channelName,
    required this.channelProfileImageUrl,
    required this.updatedAt,
  });

  factory SearchVideoModel.fromJson(Map<String, dynamic> json) {
    return SearchVideoModel(
      videoId: json['videoId'] as String,
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      durationSeconds: json['durationSeconds'] as int? ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      channelId: json['channelId'] as String,
      channelName: json['channelName'] as String? ?? '',
      channelProfileImageUrl: json['channelProfileImageUrl'] as String? ?? '',
      updatedAt: json['updatedAt'] as String,
    );
  }

  SearchVideoEntity toEntity() {
    return SearchVideoEntity(
      videoId: videoId,
      title: title,
      thumbnailUrl: thumbnailUrl,
      durationSeconds: durationSeconds,
      views: views,
      channelId: channelId,
      channelName: channelName,
      channelProfileImageUrl: channelProfileImageUrl,
      updatedAt: DateTime.tryParse(updatedAt) ?? DateTime.now(),
    );
  }
}
