import '../../domain/entities/owner_channel_entity.dart';

class OwnerChannelModel {
  final String id;
  final String title;
  final String? description;
  final String? channelImageUrl;
  final String? thumbnailUrl;
  final int videosCount;
  final int subscriptionsCount;
  final int totalViews;
  final bool isSubscribed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isOwner;

  const OwnerChannelModel({
    required this.id,
    required this.title,
    this.description,
    this.channelImageUrl,
    this.thumbnailUrl,
    this.videosCount = 0,
    this.subscriptionsCount = 0,
    this.totalViews = 0,
    this.isSubscribed = false,
    this.createdAt,
    this.updatedAt,
    this.isOwner = true,
  });

  factory OwnerChannelModel.fromJson(Map<String, dynamic> json) {
    return OwnerChannelModel(
      id: json['channelId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      channelImageUrl: json['channelImageUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      videosCount: json['videosCount'] as int? ?? 0,
      subscriptionsCount: json['subscriptionsCount'] as int? ?? 0,
      totalViews: json['totalViews'] as int? ?? 0,
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      isOwner: json['isOwner'] as bool? ?? true,
    );
  }

  OwnerChannelEntity toEntity() {
    return OwnerChannelEntity(
      id: id,
      title: title,
      description: description,
      channelImageUrl: channelImageUrl,
      thumbnailUrl: thumbnailUrl,
      videosCount: videosCount,
      subscriptionsCount: subscriptionsCount,
      totalViews: totalViews,
      isSubscribed: isSubscribed,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isOwner: isOwner,
    );
  }
}
