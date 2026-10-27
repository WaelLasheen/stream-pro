import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_feed_entity.dart';

sealed class WatchLaterState extends Equatable {
  final WatchLaterFeedEntity? feed;
  const WatchLaterState({this.feed});

  @override
  List<Object?> get props => [feed];
}

final class WatchLaterInitial extends WatchLaterState {
  const WatchLaterInitial();
}

final class WatchLaterLoading extends WatchLaterState {
  const WatchLaterLoading();
}

final class WatchLaterLoaded extends WatchLaterState {
  final bool isLoadingMore;
  @override
  WatchLaterFeedEntity get feed => super.feed!;

  const WatchLaterLoaded({
    required WatchLaterFeedEntity super.feed,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [feed, isLoadingMore];
}

final class WatchLaterEmpty extends WatchLaterState {
  const WatchLaterEmpty();
}

final class WatchLaterError extends WatchLaterState {
  final String message;

  const WatchLaterError({required this.message, super.feed});

  @override
  List<Object?> get props => [message, feed];
}
