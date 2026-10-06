import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_subscriptions_entity.dart';

abstract class SubscriptionsState extends Equatable {
  final PaginatedSubscriptionsEntity? subscriptions;

  const SubscriptionsState({this.subscriptions});

  @override
  List<Object?> get props => [subscriptions];
}

class SubscriptionsInitialState extends SubscriptionsState {
  const SubscriptionsInitialState();
}

class SubscriptionsLoadingState extends SubscriptionsState {
  const SubscriptionsLoadingState();
}

class SubscriptionsLoadedState extends SubscriptionsState {
  final bool isLoadingMore;

  const SubscriptionsLoadedState({
    required PaginatedSubscriptionsEntity super.subscriptions,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [subscriptions, isLoadingMore];
}

class SubscriptionsErrorState extends SubscriptionsState {
  final String message;

  const SubscriptionsErrorState({required this.message, super.subscriptions});

  @override
  List<Object?> get props => [message, subscriptions];
}
