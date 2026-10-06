import 'package:equatable/equatable.dart';
import 'subscription_channel_entity.dart';

class SubscriptionEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final SubscriptionChannelEntity channel;

  const SubscriptionEntity({
    required this.id,
    required this.createdAt,
    required this.channel,
  });

  @override
  List<Object?> get props => [id, createdAt, channel];
}
