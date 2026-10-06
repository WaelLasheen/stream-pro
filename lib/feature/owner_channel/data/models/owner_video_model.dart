import '../../domain/entities/owner_video_entity.dart';

class OwnerVideoModel {
  final String id;
  final String title;
  final String? videoUrl;
  final String hlsUrl;
  final String thumbnailUrl;
  final String channelId;
  final String channelTitle;
  final String channelImageUrl;
  final int durationSeconds;
  final int views;
  final bool isPublished;
  final String? description;
  final DateTime createdAt;

  const OwnerVideoModel({
    required this.id,
    required this.title,
    this.videoUrl,
    required this.hlsUrl,
    required this.thumbnailUrl,
    required this.channelId,
    required this.channelTitle,
    required this.channelImageUrl,
    required this.durationSeconds,
    required this.views,
    required this.isPublished,
    this.description,
    required this.createdAt,
  });

  factory OwnerVideoModel.fromJson(Map<String, dynamic> json) {
    return OwnerVideoModel(
      id: json['videoId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      videoUrl: json['videoUrl'] as String?,
      hlsUrl: json['hlsUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      channelId: json['channelId'] as String? ?? '',
      channelTitle: json['channelTitle'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      isPublished: json['isPublished'] as bool? ?? false,
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  OwnerVideoEntity toEntity() {
    return OwnerVideoEntity(
      id: id,
      title: title,
      videoUrl: videoUrl,
      hlsUrl: hlsUrl,
      thumbnailUrl: thumbnailUrl,
      channelId: channelId,
      channelTitle: channelTitle,
      channelImageUrl: channelImageUrl,
      durationSeconds: durationSeconds,
      views: views,
      isPublished: isPublished,
      description: description,
      createdAt: createdAt,
    );
  }
}
