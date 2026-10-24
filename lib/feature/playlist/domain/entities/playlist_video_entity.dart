import 'package:equatable/equatable.dart';

class PlaylistVideoEntity extends Equatable {
  final String videoId;
  final String title;
  final String? thumbnailUrl;
  final int durationSeconds;
  final int views;
  final DateTime createdAt;
  final String channelId;
  final String channelTitle;
  final String? channelImageUrl;

  const PlaylistVideoEntity({
    required this.videoId,
    required this.title,
    this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.createdAt,
    required this.channelId,
    required this.channelTitle,
    this.channelImageUrl,
  });

  @override
  List<Object?> get props => [
    videoId,
    title,
    thumbnailUrl,
    createdAt,
    durationSeconds,
    views,
    channelId,
    channelTitle,
    channelImageUrl,
  ];
}
