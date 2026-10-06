import 'package:equatable/equatable.dart';

abstract class ToggleSubscriptionState extends Equatable {
  final bool isSubscribed;

  const ToggleSubscriptionState(this.isSubscribed);

  @override
  List<Object?> get props => [isSubscribed];
}

class ToggleSubscriptionInitialState extends ToggleSubscriptionState {
  const ToggleSubscriptionInitialState(super.isSubscribed);
}

class ToggleSubscriptionErrorState extends ToggleSubscriptionState {
  final String message;

  const ToggleSubscriptionErrorState({
    required bool isSubscribed,
    required this.message,
  }) : super(isSubscribed);

  @override
  List<Object?> get props => [isSubscribed, message];
}
