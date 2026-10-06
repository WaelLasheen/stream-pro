import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_watch_history_use_case.dart';
import 'watch_history_state.dart';

class WatchHistoryCubit extends Cubit<WatchHistoryState> {
  final GetWatchHistoryUseCase getWatchHistoryUseCase;

  WatchHistoryCubit(this.getWatchHistoryUseCase) : super(WatchHistoryInitial());

  Future<void> fetchWatchHistory({bool silent = false}) async {
    // Only emit loading if we are NOT performing a silent background refresh
    if (!silent) {
      emit(WatchHistoryLoading());
    }

    final result = await getWatchHistoryUseCase();
    result.fold(
      (failure) {
        // If silent refresh fails, keep existing UI state intact
        if (!silent) {
          emit(WatchHistoryError(failure.message));
        }
      },
      (groups) {
        if (groups.isEmpty) {
          emit(WatchHistoryEmpty());
        } else {
          emit(WatchHistoryLoaded(groups));
        }
      },
    );
  }
}