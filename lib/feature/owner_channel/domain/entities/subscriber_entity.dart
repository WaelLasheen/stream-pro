import 'package:equatable/equatable.dart';

class SubscriberEntity extends Equatable {
  final String subscriptionId;
  final String userChannelId;
  final String name;
  final String email;
  final String avatarUrl;
  final DateTime createdAt;

  const SubscriberEntity({
    required this.subscriptionId,
    required this.userChannelId,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    subscriptionId,
    userChannelId,
    avatarUrl,
    name,
    email,
    createdAt,
  ];
}
