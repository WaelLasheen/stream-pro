import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_feed_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFeedUseCase getFeedUseCase;
  final List<String> _loadedIds = [];

  HomeCubit({required this.getFeedUseCase}) : super(const HomeInitialState());

  Future<void> fetchFeed() async {
    emit(const HomeLoadingState());
    _loadedIds.clear();

    final result = await getFeedUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeErrorState(videos: [], message: failure.message)),
      (videos) {
        _loadedIds.addAll(videos.map((v) => v.id));
        emit(HomeLoadedState(videos: videos, hasReachedMax: videos.isEmpty));
      },
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! HomeLoadedState ||
        currentState.hasReachedMax ||
        currentState.isLoadingMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await getFeedUseCase(excludeIds: _loadedIds);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        HomeErrorState(videos: currentState.videos, message: failure.message),
      ),
      (newVideos) {
        _loadedIds.addAll(newVideos.map((v) => v.id));
        emit(
          HomeLoadedState(
            videos: [...currentState.videos, ...newVideos],
            hasReachedMax: newVideos.isEmpty,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
