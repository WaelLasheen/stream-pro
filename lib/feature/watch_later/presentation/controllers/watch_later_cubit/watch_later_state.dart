import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_feed_entity.dart';

sealed class WatchLaterState extends Equatable {
  const WatchLaterState();

  @override
  List<Object?> get props => [];
}

final class WatchLaterInitial extends WatchLaterState {
  const WatchLaterInitial();
}

final class WatchLaterLoading extends WatchLaterState {
  const WatchLaterLoading();
}

final class WatchLaterLoaded extends WatchLaterState {
  final WatchLaterFeedEntity feed;

  const WatchLaterLoaded(this.feed);

  @override
  List<Object?> get props => [feed];
}

final class WatchLaterEmpty extends WatchLaterState {
  const WatchLaterEmpty();
}

final class WatchLaterError extends WatchLaterState {
  final String message;

  const WatchLaterError(this.message);

  @override
  List<Object?> get props => [message];
}
