import 'package:equatable/equatable.dart';

class SearchVideoEntity extends Equatable {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final int views;
  final String channelId;
  final String channelName;
  final String channelProfileImageUrl;
  final DateTime updatedAt;

  const SearchVideoEntity({
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

  @override
  List<Object?> get props => [
    videoId,
    title,
    thumbnailUrl,
    durationSeconds,
    views,
    channelId,
    channelName,
    channelProfileImageUrl,
    updatedAt,
  ];
}
