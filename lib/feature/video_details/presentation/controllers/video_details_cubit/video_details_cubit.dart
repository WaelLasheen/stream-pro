import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_video_details_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_state.dart';

class VideoDetailsCubit extends Cubit<VideoDetailsState> {
  final GetVideoDetailsUseCase getVideoDetailsUseCase;

  VideoDetailsCubit(this.getVideoDetailsUseCase) : super(VideoDetailsInitial());

  Future<void> loadVideoDetails(String videoId) async {
    emit(VideoDetailsLoading());
    final result = await getVideoDetailsUseCase(videoId);
    result.fold(
      (failure) => emit(VideoDetailsFailure(failure.message)),
      (video) => emit(VideoDetailsSuccess(video)),
    );
  }
}