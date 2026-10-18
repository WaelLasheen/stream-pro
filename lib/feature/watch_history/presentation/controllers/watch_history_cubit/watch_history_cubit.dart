import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_watch_history_use_case.dart';
import 'watch_history_state.dart';

class WatchHistoryCubit extends Cubit<WatchHistoryState> {
  final GetWatchHistoryUseCase getWatchHistoryUseCase;

  WatchHistoryCubit(this.getWatchHistoryUseCase) : super(WatchHistoryInitial());

  Future<void> fetchWatchHistory({bool silent = false}) async {
    if (!silent) {
      emit(WatchHistoryLoading());
    }

    final result = await getWatchHistoryUseCase();
    if (isClosed) return;

    result.fold(
      (failure) {
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
