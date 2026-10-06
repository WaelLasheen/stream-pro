import 'package:equatable/equatable.dart';

class SubscriberEntity extends Equatable {
  final String subscriptionId;
  final String channelId;
  final String userId;
  final String name;
  final String email;
  final DateTime createdAt;

  const SubscriberEntity({
    required this.subscriptionId,
    required this.channelId,
    required this.userId,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    subscriptionId,
    channelId,
    userId,
    name,
    email,
    createdAt,
  ];
}
