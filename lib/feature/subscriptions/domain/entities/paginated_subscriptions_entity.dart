import 'package:equatable/equatable.dart';
import 'subscription_entity.dart';

class PaginatedSubscriptionsEntity extends Equatable {
  final List<SubscriptionEntity> subscriptions;
  final bool hasMore;
  final String? nextCursor;

  const PaginatedSubscriptionsEntity({
    required this.subscriptions,
    required this.hasMore,
    this.nextCursor,
  });

  PaginatedSubscriptionsEntity copyWith({
    List<SubscriptionEntity>? subscriptions,
  }) {
    return PaginatedSubscriptionsEntity(
      subscriptions: subscriptions ?? this.subscriptions,
      hasMore: hasMore,
    );
  }

  @override
  List<Object?> get props => [subscriptions, hasMore, nextCursor];
}
