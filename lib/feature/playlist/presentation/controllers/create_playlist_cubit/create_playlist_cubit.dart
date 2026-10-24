import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/create_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/toggle_video_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/create_playlist_cubit/create_playlist_state.dart';

class CreatePlaylistCubit extends Cubit<CreatePlaylistState> {
  final CreatePlaylistUseCase createPlaylistUseCase;
  final ToggleVideoPlaylistUseCase toggleVideoPlaylistUseCase;

  CreatePlaylistCubit({
    required this.createPlaylistUseCase,
    required this.toggleVideoPlaylistUseCase,
  }) : super(const CreatePlaylistInitial());

  Future<void> create({
    required String title,
    required String videoId,
    String? description,
    bool isPublic = false,
  }) async {
    emit(const CreatePlaylistLoading());

    final result = await createPlaylistUseCase(
      title: title,
      description: description,
      isPublic: isPublic,
    );
    if (isClosed) return;

    final playlistId = result.fold<String?>((failure) {
      emit(CreatePlaylistFailure(errorMessage: failure.message));
      return null;
    }, (playlistId) => playlistId);
    if (playlistId == null) return;

    final addResult = await toggleVideoPlaylistUseCase(
      playlistId: playlistId,
      videoId: videoId,
      hasVideo: false,
    );
    if (isClosed) return;

    addResult.fold(
      (failure) => emit(CreatePlaylistFailure(errorMessage: failure.message)),
      (_) => emit(
        CreatePlaylistSuccess(
          playlistId: playlistId,
          title: title,
          isPublic: isPublic,
        ),
      ),
    );
  }
}
