import 'package:equatable/equatable.dart';
import '../../../domain/entities/watch_history_entity.dart';

sealed class WatchHistoryState extends Equatable {
  final List<WatchHistoryEntity> groups;
  const WatchHistoryState({this.groups = const []});

  @override
  List<Object?> get props => [];
}

class WatchHistoryInitial extends WatchHistoryState {}

class WatchHistoryLoading extends WatchHistoryState {}

class WatchHistoryLoaded extends WatchHistoryState {
  final bool isLoadingMore;
  final bool hasMore;

  const WatchHistoryLoaded({
    required super.groups,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [groups, isLoadingMore, hasMore];
}

class WatchHistoryEmpty extends WatchHistoryState {}

class WatchHistoryError extends WatchHistoryState {
  final String message;

  const WatchHistoryError({required this.message, super.groups});

  @override
  List<Object?> get props => [message, groups];
}
