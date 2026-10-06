import '../../domain/entities/subscription_channel_entity.dart';

class SubscriptionChannelModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String? description;
  final int subscriberCount;

  const SubscriptionChannelModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.description,
    required this.subscriberCount,
  });

  factory SubscriptionChannelModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionChannelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      description: json['description'] as String?,
      subscriberCount: (json['subscriberCount'] as num?)?.toInt() ?? 0,
    );
  }

  SubscriptionChannelEntity toEntity() {
    return SubscriptionChannelEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      description: description,
      subscriberCount: subscriberCount,
    );
  }
}
