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
        if (showLoading) emit(WatchLaterError(message: failure.message));
      },
      (feed) => emit(
        feed.items.isEmpty
            ? const WatchLaterEmpty()
            : WatchLaterLoaded(feed: feed),
      ),
    );
  }

  void removeLocally(String videoId) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final items = currentFeed.items
        .where((item) => item.video.id != videoId)
        .toList();

    if (items.length == currentFeed.items.length) return;

    if (items.isEmpty) {
      emit(const WatchLaterEmpty());
      return;
    }

    emit(
      WatchLaterLoaded(
        feed: currentFeed.copyWith(items: items, videoCount: items.length),
      ),
    );
  }

  Future<void> fetchMore() async {
    final currentState = state;
    final currentFeed = currentState.feed;

    if (currentFeed == null ||
        currentState is WatchLaterEmpty ||
        !currentFeed.hasMore ||
        (currentState is WatchLaterLoaded && currentState.isLoadingMore)) {
      return;
    }

    final cursor = currentFeed.items.last.id;
    emit(WatchLaterLoaded(feed: currentFeed, isLoadingMore: true));

    final result = await getWatchLaterUseCase(cursor: cursor);
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(WatchLaterError(message: failure.message, feed: currentFeed)),
      (feed) => emit(
        WatchLaterLoaded(
          feed: currentFeed.copyWith(
            items: [...currentFeed.items, ...feed.items],
            videoCount: feed.videoCount,
          ),
        ),
      ),
    );
  }
}
