import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_subscriptions_use_case.dart';
import 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final GetSubscriptionsUseCase getSubscriptionsUseCase;

  SubscriptionsCubit({required this.getSubscriptionsUseCase})
    : super(const SubscriptionsInitialState());

  Future<void> fetchUserSubscriptions() async {
    emit(const SubscriptionsLoadingState());

    final result = await getSubscriptionsUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(SubscriptionsErrorState(message: failure.message)),
      (response) => emit(SubscriptionsLoadedState(subscriptions: response)),
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    final currentSubscriptions = currentState.subscriptions;

    if (currentSubscriptions == null ||
        !currentSubscriptions.hasMore ||
        currentSubscriptions.nextCursor == null) {
      return;
    }

    if (currentState is SubscriptionsLoadedState &&
        currentState.isLoadingMore) {
      return;
    }

    emit(
      SubscriptionsLoadedState(
        subscriptions: currentSubscriptions,
        isLoadingMore: true,
      ),
    );

    final List<String> nextCursor = [currentSubscriptions.nextCursor!];

    final result = await getSubscriptionsUseCase(cursor: nextCursor);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        SubscriptionsErrorState(
          message: failure.message,
          subscriptions: currentSubscriptions,
        ),
      ),
      (response) => emit(
        SubscriptionsLoadedState(
          subscriptions: response.copyWith(
            subscriptions: [
              ...currentSubscriptions.subscriptions,
              ...response.subscriptions,
            ],
          ),
          isLoadingMore: false,
        ),
      ),
    );
  }
}
