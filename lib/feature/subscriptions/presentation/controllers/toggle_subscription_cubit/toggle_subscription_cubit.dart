import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/subscribe_to_channel_use_case.dart';
import '../../../domain/use_cases/unsubscribe_to_channel_use_case.dart';
import 'toggle_subscription_state.dart';

class ToggleSubscriptionCubit extends Cubit<ToggleSubscriptionState> {
  final SubscribeToChannelUseCase subscribeToChannelUseCase;
  final UnsubscribeToChannelUseCase unsubscribeFromChannelUseCase;

  bool _isProcessing = false;

  ToggleSubscriptionCubit({
    required this.subscribeToChannelUseCase,
    required this.unsubscribeFromChannelUseCase,
  }) : super(const ToggleSubscriptionInitialState(false));

  void init(bool initialSubscribed) {
    emit(ToggleSubscriptionInitialState(initialSubscribed));
    _isProcessing = false;
  }

  Future<void> toggleSubscription(
    String channelId,
    bool currentlySubscribed,
  ) async {
    // Prevent concurrent API calls if the user spams the button
    if (_isProcessing) return;
    _isProcessing = true;

    // 1. OPTIMISTIC UPDATE: Instantly update the UI
    final newSubscribedState = !currentlySubscribed;
    emit(ToggleSubscriptionInitialState(newSubscribedState));

    // 2. BACKGROUND API CALL
    final result = newSubscribedState
        ? await subscribeToChannelUseCase(channelId)
        : await unsubscribeFromChannelUseCase(channelId);

    _isProcessing = false;
    if (isClosed) return;

    // 3. HANDLE RESULT
    result.fold(
      (failure) {
        // Revert to the previous state on failure
        emit(
          ToggleSubscriptionErrorState(
            isSubscribed: currentlySubscribed,
            message: failure.message,
          ),
        );
      },
      (_) {
        // Success! The optimistic state is already correct.
        // We just clear any lingering error state if it existed.
        if (state is ToggleSubscriptionErrorState) {
          emit(ToggleSubscriptionInitialState(newSubscribedState));
        }
      },
    );
  }
}
