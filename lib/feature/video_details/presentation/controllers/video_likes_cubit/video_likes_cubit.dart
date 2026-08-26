import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/toggle_like_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_likes_cubit/video_likes_state.dart';

class VideoLikesCubit extends Cubit<VideoLikesState> {
  final ToggleLikeUseCase toggleLikeUseCase;

  VideoLikesCubit(this.toggleLikeUseCase)
      : super(const VideoLikesInitial(isLiked: false, likesCount: 0));

  void init({required bool isLiked, required int likesCount}) {
    emit(VideoLikesInitial(isLiked: isLiked, likesCount: likesCount));
  }

  Future<void> toggleLike(String videoId) async {
    final currentIsLiked = state.isLiked;
    final currentCount = state.likesCount;

    final optimisticIsLiked = !currentIsLiked;
    final optimisticCount = optimisticIsLiked ? currentCount + 1 : currentCount - 1;

    // Optimistic UI Update
    emit(VideoLikesUpdated(isLiked: optimisticIsLiked, likesCount: optimisticCount));

    final result = await toggleLikeUseCase(
      videoId: videoId,
      isCurrentlyLiked: currentIsLiked,
    );

    result.fold(
      (failure) {
        // Revert on failure
        emit(VideoLikesFailure(
          isLiked: currentIsLiked,
          likesCount: currentCount,
          errorMessage: failure.message,
        ));
      },
      (_) {},
    );
  }
}