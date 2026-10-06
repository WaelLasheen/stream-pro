import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/Likes/domain/use_cases/toggle_like_use_case.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/likes_cubit/likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  final ToggleLikeUseCase toggleLikeUseCase;

  LikesCubit(this.toggleLikeUseCase)
    : super(const LikesInitial(isLiked: false, likesCount: 0));

  void init({required bool isLiked, required int likesCount}) {
    emit(LikesInitial(isLiked: isLiked, likesCount: likesCount));
  }

  Future<void> toggleLike(String videoId) async {
    final currentIsLiked = state.isLiked;
    final currentCount = state.likesCount;

    final optimisticIsLiked = !currentIsLiked;
    final optimisticCount = optimisticIsLiked
        ? currentCount + 1
        : currentCount - 1;

    emit(LikesUpdated(isLiked: optimisticIsLiked, likesCount: optimisticCount));

    final result = await toggleLikeUseCase(
      videoId: videoId,
      isCurrentlyLiked: currentIsLiked,
    );

    result.fold((failure) {
      emit(
        LikesFailure(
          isLiked: currentIsLiked,
          likesCount: currentCount,
          errorMessage: failure.message,
        ),
      );
    }, (_) {});
  }
}
