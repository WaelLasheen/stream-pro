import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/video_details/domain/entities/related_video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_related_videos_use_case.dart';

part 'related_videos_state.dart';

class RelatedVideosCubit extends Cubit<RelatedVideosState> {
  final GetRelatedVideosUseCase _getRelatedVideosUseCase;
  RelatedVideosCubit(this._getRelatedVideosUseCase)
    : super(RelatedVideosInitial());

  Future<void> fetchRelatedVideos(String videoId) async {
    emit(RelatedVideosLoading());
    final response = await _getRelatedVideosUseCase(videoId);
    if (isClosed) return;
    response.fold(
      (failure) => emit(RelatedVideosFailure(message: failure.message)),
      (videos) => emit(RelatedVideosLoaded(videos: videos)),
    );
  }
}
