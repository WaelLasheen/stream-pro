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
  final DateTime updatedAt;

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
    required this.updatedAt,
  });

  factory ChannelDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChannelDetailsModel(
      channelId: json['channelId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
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
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
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
      updatedAt: updatedAt,
    );
  }
}