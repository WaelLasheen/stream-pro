import 'subscription_channel_model.dart';
import '../../domain/entities/subscription_entity.dart';

class SubscriptionModel {
  final String id;
  final DateTime createdAt;
  final SubscriptionChannelModel channel;

  const SubscriptionModel({
    required this.id,
    required this.createdAt,
    required this.channel,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      channel: SubscriptionChannelModel.fromJson(
        json['channel'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  SubscriptionEntity toEntity() {
    return SubscriptionEntity(
      id: id,
      createdAt: createdAt,
      channel: channel.toEntity(),
    );
  }
}
