import 'package:equatable/equatable.dart';

/// A video as returned by the owner-scoped `/api/v1/owner/videos` endpoint —
/// richer than the public `ChannelVideoEntity` (channel/publish info instead
/// of the viewer-specific isLikedByUser/isInWatchLater flags).
class OwnerVideoEntity extends Equatable {
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

  const OwnerVideoEntity({
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

  @override
  List<Object?> get props => [
    id,
    title,
    videoUrl,
    hlsUrl,
    thumbnailUrl,
    channelId,
    channelTitle,
    channelImageUrl,
    durationSeconds,
    views,
    isPublished,
    description,
    createdAt,
  ];
}
