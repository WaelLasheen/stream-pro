import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/is_in_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/toggle_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_button_cubit/watch_later_button_state.dart';

class WatchLaterButtonCubit extends Cubit<WatchLaterButtonState> {
  final IsInWatchLaterUseCase isInWatchLaterUseCase;
  final ToggleWatchLaterUseCase toggleWatchLaterUseCase;

  WatchLaterButtonCubit({
    required this.isInWatchLaterUseCase,
    required this.toggleWatchLaterUseCase,
  }) : super(const WatchLaterButtonState());

  Future<void> loadStatus(String videoId) async {
    final result = await isInWatchLaterUseCase(videoId: videoId);
    if (isClosed) return;

    result.fold(
      (_) => emit(state.copyWith(isLoadingStatus: false)),
      (isInWatchLater) => emit(
        state.copyWith(isInWatchLater: isInWatchLater, isLoadingStatus: false),
      ),
    );
  }

  Future<Either<Failure, bool>?> toggle(String videoId) async {
    if (state.isBusy) return null;

    emit(state.copyWith(isUpdating: true));

    final result = await toggleWatchLaterUseCase(videoId: videoId);
    if (isClosed) return null;

    result.fold(
      (_) => emit(state.copyWith(isUpdating: false)),
      (isInWatchLater) => emit(
        state.copyWith(isInWatchLater: isInWatchLater, isUpdating: false),
      ),
    );

    return result;
  }
}
