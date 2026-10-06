import 'package:equatable/equatable.dart';

class ChannelVideoEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int duration;
  final int views;
  final DateTime createdAt;
  final bool isLikedByUser;
  final bool isInWatchLater;

  const ChannelVideoEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
    required this.views,
    required this.createdAt,
    required this.isLikedByUser,
    required this.isInWatchLater,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    duration,
    thumbnailUrl,
    views,
    createdAt,
    isLikedByUser,
    isInWatchLater,
  ];
}
