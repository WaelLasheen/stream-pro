import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_subscribers_entity.dart';

abstract class SubscribersState extends Equatable {
  final PaginatedSubscribersEntity? subscribers;

  const SubscribersState({this.subscribers});

  @override
  List<Object?> get props => [subscribers];
}

class SubscribersInitialState extends SubscribersState {
  const SubscribersInitialState();
}

class SubscribersLoadingState extends SubscribersState {
  const SubscribersLoadingState();
}

class SubscribersLoadedState extends SubscribersState {
  final bool isLoadingMore;

  const SubscribersLoadedState({
    required PaginatedSubscribersEntity super.subscribers,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [subscribers, isLoadingMore];
}

class SubscribersErrorState extends SubscribersState {
  final String message;

  const SubscribersErrorState({required this.message, super.subscribers});

  @override
  List<Object?> get props => [message, subscribers];
}
