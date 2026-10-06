import 'package:equatable/equatable.dart';

class SubscriptionChannelEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String? description;
  final int subscriberCount;

  const SubscriptionChannelEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.description,
    required this.subscriberCount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    thumbnailUrl,
    description,
    subscriberCount,
  ];
}
