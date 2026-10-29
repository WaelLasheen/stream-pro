import 'package:stream_pro/feature/owner_channel/domain/entities/subscriber_entity.dart';

class SubscriberModel {
  final String subscriptionId;
  final String userChannelId;
  final String name;
  final String email;
  final String avatarUrl;
  final DateTime createdAt;

  const SubscriberModel({
    required this.subscriptionId,
    required this.userChannelId,
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory SubscriberModel.fromJson(Map<String, dynamic> json) {
    return SubscriberModel(
      subscriptionId: json['subscriptionId'] as String? ?? '',
      userChannelId: json['userChannelId'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  SubscriberEntity toEntity() {
    return SubscriberEntity(
      subscriptionId: subscriptionId,
      userChannelId: userChannelId,
      avatarUrl: avatarUrl,
      name: name,
      email: email,
      createdAt: createdAt,
    );
  }
}
