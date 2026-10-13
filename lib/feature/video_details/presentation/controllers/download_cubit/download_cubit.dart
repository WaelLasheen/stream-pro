import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/download_video_use_case.dart';
import 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final DownloadVideoUseCase downloadVideoUseCase;

  DownloadCubit({required this.downloadVideoUseCase})
    : super(DownloadInitial());

  Future<void> downloadVideo(String videoId) async {
    if (state is DownloadInProgress) return;

    emit(const DownloadInProgress(0.0));

    final result = await downloadVideoUseCase(
      videoId: videoId,
      onReceiveProgress: (received, total) {
        if (isClosed) return;
        if (total <= 0) {
          emit(const DownloadInProgress(-1));
        } else {
          emit(DownloadInProgress(received / total));
        }
      },
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(DownloadError(failure.message)),
      (_) => emit(DownloadSuccess()),
    );
  }
}
