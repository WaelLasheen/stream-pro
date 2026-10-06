import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_subscribers_use_case.dart';
import 'subscribers_state.dart';

class SubscribersCubit extends Cubit<SubscribersState> {
  final GetSubscribersUseCase getSubscribersUseCase;

  SubscribersCubit({required this.getSubscribersUseCase})
    : super(const SubscribersInitialState());

  bool _hasMore = true;

  Future<void> fetchSubscribers() async {
    emit(const SubscribersLoadingState());
    final result = await getSubscribersUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(SubscribersErrorState(message: failure.message)),
      (paginatedEntity) =>
          emit(SubscribersLoadedState(subscribers: paginatedEntity)),
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    final currentSubscribers = currentState.subscribers;

    if (currentSubscribers == null || !_hasMore) return;

    if (currentState is SubscribersLoadedState && currentState.isLoadingMore) {
      return;
    }

    emit(
      SubscribersLoadedState(
        subscribers: currentSubscribers,
        isLoadingMore: true,
      ),
    );

    final nextPage = currentSubscribers.pageNumber + 1;
    final result = await getSubscribersUseCase(pageNumber: nextPage);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        SubscribersErrorState(
          message: failure.message,
          subscribers: currentSubscribers,
        ),
      ),
      (response) {
        _hasMore = response.items.length == 10;
        emit(
          SubscribersLoadedState(
            subscribers: response.copyWith(
              items: [...currentSubscribers.items, ...response.items],
            ),
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
