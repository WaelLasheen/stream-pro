import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';

class VideoModel {
  final String videoId;
  final String title;
  final String videoUrl;
  final String thumbnailUrl;
  final String channelId;
  final String channelTitle;
  final String channelImageUrl;
  final int duration;
  final int views;
  final String description;
  final int commentsCount;
  final int likesCount;
  final int channelSubscribersCount;
  final bool isSubscribed;
  final bool isLiked;
  final String createdAt;

  VideoModel({
    required this.videoId,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.channelId,
    required this.channelTitle,
    required this.channelImageUrl,
    required this.duration,
    required this.views,
    required this.description,
    required this.commentsCount,
    required this.likesCount,
    required this.channelSubscribersCount,
    required this.isSubscribed,
    required this.isLiked,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoId: json['videoId'] ?? '',
      title: json['title'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      channelId: json['channelId'] ?? '',
      channelTitle: json['channelTitle'] ?? '',
      channelImageUrl: json['channelImageUrl'] ?? '',
      duration: json['duration'] ?? 0,
      views: json['views'] ?? 0,
      description: json['description'] ?? '',
      commentsCount: json['commentsCount'] ?? 0,
      likesCount: json['likesCount'] ?? 0,
      channelSubscribersCount: json['channelSubscribersCount'] ?? 0,
      isSubscribed: json['isSubscribed'] ?? false,
      isLiked: json['isLiked'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }

  VideoEntity toEntity() {
    return VideoEntity(
      videoId: videoId,
      title: title,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      channelId: channelId,
      channelTitle: channelTitle,
      channelImageUrl: channelImageUrl,
      duration: duration,
      views: views,
      description: description,
      commentsCount: commentsCount,
      likesCount: likesCount,
      channelSubscribersCount: channelSubscribersCount,
      isSubscribed: isSubscribed,
      isLiked: isLiked,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    );
  }
}