import 'package:equatable/equatable.dart';

class ChannelDetailsEntity extends Equatable {
  final String channelId;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final String channelImageUrl;
  final int videosCount;
  final int subscriptionsCount;
  final int totalViews;
  final bool isSubscribed;
  final bool isOwner;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ChannelDetailsEntity({
    required this.channelId,
    required this.title,
    this.description,
    required this.thumbnailUrl,
    required this.channelImageUrl,
    required this.videosCount,
    required this.subscriptionsCount,
    required this.totalViews,
    required this.isSubscribed,
    required this.isOwner,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        channelId,
        title,
        description,
        thumbnailUrl,
        channelImageUrl,
        videosCount,
        subscriptionsCount,
        totalViews,
        isSubscribed,
        isOwner,
        createdAt,
        updatedAt,
      ];
}