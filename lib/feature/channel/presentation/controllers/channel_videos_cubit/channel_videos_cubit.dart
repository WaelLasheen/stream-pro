import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_channel_videos_use_case.dart';
import 'channel_videos_state.dart';

class ChannelVideosCubit extends Cubit<ChannelVideosState> {
  final GetChannelVideosUseCase getChannelVideosUseCase;

  ChannelVideosCubit({required this.getChannelVideosUseCase})
    : super(const ChannelVideosInitialState());

  Future<void> fetchChannelVideos(String channelId) async {
    emit(const ChannelVideosLoadingState());

    final result = await getChannelVideosUseCase(channelId, pageNumber: 1);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ChannelVideosErrorState(message: failure.message)),
      (videos) => emit(ChannelVideosLoadedState(videos: videos)),
    );
  }

  Future<void> loadMoreVideos(String channelId) async {
    final currentState = state;
    final currentVideos = currentState.videos;

    if (currentVideos == null || !currentVideos.hasNextPage) return;

    if (currentState is ChannelVideosLoadedState &&
        currentState.isLoadingMore) {
      return;
    }

    emit(ChannelVideosLoadedState(videos: currentVideos, isLoadingMore: true));

    final nextPage = currentVideos.pageNumber + 1;
    final result = await getChannelVideosUseCase(
      channelId,
      pageNumber: nextPage,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        ChannelVideosErrorState(
          message: failure.message,
          videos: currentVideos,
        ),
      ),
      (newVideos) => emit(
        ChannelVideosLoadedState(
          videos: newVideos.copyWith(
            items: [...currentVideos.items, ...newVideos.items],
          ),
          isLoadingMore: false,
        ),
      ),
    );
  }
}
