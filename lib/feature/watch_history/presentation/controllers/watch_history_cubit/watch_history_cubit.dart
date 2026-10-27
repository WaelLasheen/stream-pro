import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/watch_history_entity.dart';
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
          emit(WatchHistoryError(message: failure.message));
        }
      },
      (groups) {
        if (groups.isEmpty) {
          emit(WatchHistoryEmpty());
        } else {
          emit(WatchHistoryLoaded(groups: groups));
        }
      },
    );
  }

  Future<void> fetchMore() async {
    final currentState = state;
    final currentGroups = currentState.groups;

    if (currentGroups.isEmpty ||
        (currentState is WatchHistoryLoaded &&
            (!currentState.hasMore || currentState.isLoadingMore))) {
      return;
    }

    final cursor = _lastItemId(currentState.groups);
    emit(WatchHistoryLoaded(groups: currentState.groups, isLoadingMore: true));

    final result = await getWatchHistoryUseCase(cursor: cursor);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        WatchHistoryError(
          groups: currentState.groups,
          message: failure.message,
        ),
      ),
      (groups) {
        if (groups.isEmpty) {
          emit(WatchHistoryLoaded(groups: currentState.groups, hasMore: false));
          return;
        }

        emit(
          WatchHistoryLoaded(groups: _mergeGroups(currentState.groups, groups)),
        );
      },
    );
  }

  String _lastItemId(List<WatchHistoryEntity> groups) {
    return groups.last.items.last.id;
  }

  List<WatchHistoryEntity> _mergeGroups(
    List<WatchHistoryEntity> currentGroups,
    List<WatchHistoryEntity> incomingGroups,
  ) {
    final merged = [...currentGroups];

    if (merged.last.label == incomingGroups.first.label) {
      merged.last.items.addAll(incomingGroups.first.items);
      merged.addAll(incomingGroups.sublist(1));
    } else {
      merged.addAll(incomingGroups);
    }

    return merged;
  }
}
