import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
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
  final DateTime createdAt;

  const VideoEntity({
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

  VideoEntity copyWith({
    String? videoId,
    String? title,
    String? videoUrl,
    String? thumbnailUrl,
    String? channelId,
    String? channelTitle,
    String? channelImageUrl,
    int? duration,
    int? views,
    String? description,
    int? commentsCount,
    int? likesCount,
    int? channelSubscribersCount,
    bool? isSubscribed,
    bool? isLiked,
    DateTime? createdAt,
  }) {
    return VideoEntity(
      videoId: videoId ?? this.videoId,
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      channelId: channelId ?? this.channelId,
      channelTitle: channelTitle ?? this.channelTitle,
      channelImageUrl: channelImageUrl ?? this.channelImageUrl,
      duration: duration ?? this.duration,
      views: views ?? this.views,
      description: description ?? this.description,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
      channelSubscribersCount:
          channelSubscribersCount ?? this.channelSubscribersCount,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    videoId,
    title,
    videoUrl,
    thumbnailUrl,
    channelId,
    channelTitle,
    channelImageUrl,
    duration,
    views,
    description,
    commentsCount,
    likesCount,
    channelSubscribersCount,
    isSubscribed,
    isLiked,
    createdAt,
  ];
}
