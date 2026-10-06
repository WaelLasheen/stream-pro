import 'package:stream_pro/feature/owner_channel/domain/entities/subscriber_entity.dart';

class SubscriberModel {
  final String subscriptionId;
  final String channelId;
  final String userId;
  final String name;
  final String email;
  final DateTime createdAt;

  const SubscriberModel({
    required this.subscriptionId,
    required this.channelId,
    required this.userId,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory SubscriberModel.fromJson(Map<String, dynamic> json) {
    return SubscriberModel(
      subscriptionId: json['subscriptionId'] as String? ?? '',
      channelId: json['channelId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
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
      channelId: channelId,
      userId: userId,
      name: name,
      email: email,
      createdAt: createdAt,
    );
  }
}
