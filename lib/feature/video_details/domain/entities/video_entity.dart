import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String videoId;
  final String title;
  final String hlsUrl;
  final String thumbnailUrl;
  final String channelId;
  final String channelTitle;
  final String channelImageUrl;
  final int durationSeconds;
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
    required this.hlsUrl,
    required this.thumbnailUrl,
    required this.channelId,
    required this.channelTitle,
    required this.channelImageUrl,
    required this.durationSeconds,
    required this.views,
    required this.description,
    required this.commentsCount,
    required this.likesCount,
    required this.channelSubscribersCount,
    required this.isSubscribed,
    required this.isLiked,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    videoId,
    title,
    hlsUrl,
    thumbnailUrl,
    channelId,
    channelTitle,
    channelImageUrl,
    durationSeconds,
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
