import 'package:equatable/equatable.dart';
import '../../../domain/entities/watch_history_entity.dart';

sealed class WatchHistoryState extends Equatable {
  const WatchHistoryState();

  @override
  List<Object?> get props => [];
}

class WatchHistoryInitial extends WatchHistoryState {}

class WatchHistoryLoading extends WatchHistoryState {}

class WatchHistoryLoaded extends WatchHistoryState {
  final List<WatchHistoryEntity> groups;

  const WatchHistoryLoaded(this.groups);

  @override
  List<Object?> get props => [groups];
}

class WatchHistoryEmpty extends WatchHistoryState {}

class WatchHistoryError extends WatchHistoryState {
  final String message;

  const WatchHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
