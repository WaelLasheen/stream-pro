import '../../domain/entities/channel_details_entity.dart';

class ChannelDetailsModel {
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

  const ChannelDetailsModel({
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
  });

  factory ChannelDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChannelDetailsModel(
      channelId: json['channelId'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
      videosCount: (json['videosCount'] as num?)?.toInt() ?? 0,
      subscriptionsCount: (json['subscriptionsCount'] as num?)?.toInt() ?? 0,
      totalViews: (json['totalViews'] as num?)?.toInt() ?? 0,
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      isOwner: json['isOwner'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  ChannelDetailsEntity toEntity() {
    return ChannelDetailsEntity(
      channelId: channelId,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      channelImageUrl: channelImageUrl,
      videosCount: videosCount,
      subscriptionsCount: subscriptionsCount,
      totalViews: totalViews,
      isSubscribed: isSubscribed,
      isOwner: isOwner,
      createdAt: createdAt,
    );
  }
}
