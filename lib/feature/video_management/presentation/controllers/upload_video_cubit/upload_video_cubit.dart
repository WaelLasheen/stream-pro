import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/video_management/domain/entities/upload_video_params.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/upload_video_use_case.dart';
import 'upload_video_state.dart';

class UploadVideoCubit extends Cubit<UploadVideoState> {
  final UploadVideoUseCase uploadVideoUseCase;

  UploadVideoCubit(this.uploadVideoUseCase) : super(UploadVideoInitial());

  Future<void> uploadVideo(UploadVideoParams params) async {
    if (state is UploadVideoLoading) return;

    emit(UploadVideoLoading());

    final result = await uploadVideoUseCase(params);
    if (isClosed) return;

    result.fold(
      (failure) => emit(UploadVideoError(failure.message)),
      (_) => emit(UploadVideoSuccess()),
    );
  }
}
