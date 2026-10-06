import 'package:equatable/equatable.dart';

class OwnerChannelEntity extends Equatable {
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

  const OwnerChannelEntity({
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

  OwnerChannelEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? channelImageUrl,
    String? thumbnailUrl,
    int? videosCount,
    int? subscriptionsCount,
    int? totalViews,
    bool? isSubscribed,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isOwner,
  }) {
    return OwnerChannelEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      channelImageUrl: channelImageUrl ?? this.channelImageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videosCount: videosCount ?? this.videosCount,
      subscriptionsCount: subscriptionsCount ?? this.subscriptionsCount,
      totalViews: totalViews ?? this.totalViews,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isOwner: isOwner ?? this.isOwner,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    channelImageUrl,
    thumbnailUrl,
    videosCount,
    subscriptionsCount,
    totalViews,
    isSubscribed,
    createdAt,
    updatedAt,
    isOwner,
  ];
}
