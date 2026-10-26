import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/get_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_state.dart';

class WatchLaterCubit extends Cubit<WatchLaterState> {
  final GetWatchLaterUseCase getWatchLaterUseCase;

  WatchLaterCubit({required this.getWatchLaterUseCase})
    : super(const WatchLaterInitial());

  Future<void> fetchWatchLater({bool showLoading = true}) async {
    if (showLoading) emit(const WatchLaterLoading());

    final result = await getWatchLaterUseCase();
    if (isClosed) return;

    result.fold(
      (failure) {
        if (showLoading) emit(WatchLaterError(failure.message));
      },
      (feed) => emit(
        feed.items.isEmpty ? const WatchLaterEmpty() : WatchLaterLoaded(feed),
      ),
    );
  }

  void removeLocally(String videoId) {
    final currentState = state;
    if (currentState is! WatchLaterLoaded) return;

    final items = currentState.feed.items
        .where((item) => item.video.id != videoId)
        .toList();

    if (items.length == currentState.feed.items.length) return;

    if (items.isEmpty) {
      emit(const WatchLaterEmpty());
      return;
    }

    emit(
      WatchLaterLoaded(
        currentState.feed.copyWith(
          items: items,
          videoCount: currentState.feed.videoCount > 0
              ? currentState.feed.videoCount - 1
              : 0,
        ),
      ),
    );
  }

  Future<void> fetchMore() async {}
}
