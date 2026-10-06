import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/params/update_video_params.dart';
import '../../../domain/use_cases/change_video_publish_status_use_case.dart';
import '../../../domain/use_cases/change_video_thumbnail_use_case.dart';
import '../../../domain/use_cases/delete_video_use_case.dart';
import '../../../domain/use_cases/get_managed_video_use_case.dart';
import '../../../domain/use_cases/update_video_use_case.dart';
import 'edit_video_state.dart';

class EditVideoCubit extends Cubit<EditVideoState> {
  final GetManagedVideoUseCase getManagedVideoUseCase;
  final UpdateVideoUseCase updateVideoUseCase;
  final DeleteVideoUseCase deleteVideoUseCase;
  final ChangeVideoPublishStatusUseCase changePublishStatusUseCase;
  final ChangeVideoThumbnailUseCase changeThumbnailUseCase;

  EditVideoCubit({
    required this.getManagedVideoUseCase,
    required this.updateVideoUseCase,
    required this.deleteVideoUseCase,
    required this.changePublishStatusUseCase,
    required this.changeThumbnailUseCase,
  }) : super(const EditVideoInitial());

  Future<void> loadVideo({required String videoId}) async {
    emit(const EditVideoLoading());

    final result = await getManagedVideoUseCase(videoId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(EditVideoError(message: failure.message)),
      (video) => emit(EditVideoLoaded(video: video)),
    );
  }

  Future<void> update({
    required UpdateVideoParams params,
    required bool isPublic,
    String? thumbnailPath,
  }) async {
    final currentVideo = state.video;
    if (currentVideo == null) return;

    emit(EditVideoLoading(video: currentVideo));

    final List<Future> updateTasks = [];
    List<String> errors = [];
    UpdateVideoParams? newParams;
    bool? newPublicStatus;
    String? newThumbnail;

    if (params.title != currentVideo.title ||
        params.description != currentVideo.description ||
        params.categoryId != currentVideo.categoryId ||
        params.tags != currentVideo.tags ||
        params.publishTime != currentVideo.publishTime) {
      updateTasks.add(() async {
        final result = await updateVideoUseCase(currentVideo.id, params);
        result.fold((_) => errors.add('Info'), (_) => newParams = params);
      }());
    }

    if (currentVideo.isPublished != isPublic) {
      updateTasks.add(() async {
        final result = await changePublishStatusUseCase(currentVideo.id);
        result.fold(
          (_) => errors.add('Status'),
          (_) => newPublicStatus = isPublic,
        );
      }());
    }

    if (thumbnailPath != null && thumbnailPath.isNotEmpty) {
      updateTasks.add(() async {
        final result = await changeThumbnailUseCase(
          videoId: currentVideo.id,
          filePath: thumbnailPath,
        );
        result.fold(
          (_) => errors.add('Thumbnail'),
          (url) => newThumbnail = url,
        );
      }());
    }

    await Future.wait(updateTasks);
    if (isClosed) return;

    emit(
      EditVideoUpdated(
        video: currentVideo.copyWith(
          title: newParams?.title,
          description: newParams?.description,
          categoryId: newParams?.categoryId,
          publishTime: newParams?.publishTime,
          tags: newParams?.tags,
          isPublished: newPublicStatus,
          thumbnailUrl: newThumbnail,
        ),
      ),
    );
  }

  Future<void> deleteVideo() async {
    final current = state.video;
    if (current == null) return;

    final result = await deleteVideoUseCase(current.id);
    if (isClosed) return;

    result.fold((failure) {
      emit(EditVideoError(message: failure.message, video: current));
    }, (_) => emit(const EditVideoDeleted()));
  }
}
