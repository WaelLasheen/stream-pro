import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_owner_videos_use_case.dart';
import 'owner_videos_state.dart';

class OwnerVideosCubit extends Cubit<OwnerVideosState> {
  final GetOwnerVideosUseCase getOwnerVideosUseCase;

  OwnerVideosCubit({required this.getOwnerVideosUseCase})
    : super(const OwnerVideosInitialState());

  Future<void> fetchOwnerVideos() async {
    emit(const OwnerVideosLoadingState());

    final result = await getOwnerVideosUseCase(pageNumber: 1);
    if (isClosed) return;

    result.fold(
      (failure) => emit(OwnerVideosErrorState(message: failure.message)),
      (videos) => emit(OwnerVideosLoadedState(videos: videos)),
    );
  }

  Future<void> loadMoreVideos() async {
    final currentState = state;
    final currentVideos = currentState.videos;

    if (currentVideos == null || !currentVideos.hasNextPage) return;

    if (currentState is OwnerVideosLoadedState && currentState.isLoadingMore) {
      return;
    }

    emit(OwnerVideosLoadedState(videos: currentVideos, isLoadingMore: true));

    final nextPage = currentVideos.pageNumber + 1;
    final result = await getOwnerVideosUseCase(pageNumber: nextPage);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        OwnerVideosErrorState(message: failure.message, videos: currentVideos),
      ),
      (newVideos) => emit(
        OwnerVideosLoadedState(
          videos: newVideos.copyWith(
            items: [...currentVideos.items, ...newVideos.items],
          ),
          isLoadingMore: false,
        ),
      ),
    );
  }
}
