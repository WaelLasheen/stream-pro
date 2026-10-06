import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/Likes/domain/use_cases/get_liked_videos_use_case.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_state.dart';

class LikedVideosCubit extends Cubit<LikedVideosState> {
  final GetLikedVideosUseCase getLikedVideosUseCase;

  LikedVideosCubit(this.getLikedVideosUseCase)
    : super(const LikedVideosInitial());

  Future<void> fetchLikedVideos() async {
    emit(const LikedVideosLoading());

    final result = await getLikedVideosUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(LikedVideosError(failure.message)),
      (feed) => emit(LikedVideosLoaded(feed)),
    );
  }
}
