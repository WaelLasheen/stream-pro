import 'package:equatable/equatable.dart';

class RelatedVideoEntity extends Equatable {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final int views;
  final String channelId;
  final String channelTitle;
  final String channelImageUrl;

  const RelatedVideoEntity({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.channelId,
    required this.channelTitle,
    required this.channelImageUrl,
  });

  @override
  List<Object?> get props => [
    videoId,
    title,
    thumbnailUrl,
    durationSeconds,
    views,
    channelId,
    channelTitle,
    channelImageUrl,
  ];
}
