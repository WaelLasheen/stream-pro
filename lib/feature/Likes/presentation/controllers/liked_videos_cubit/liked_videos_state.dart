import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/Likes/domain/entities/liked_videos_feed_entity.dart';

sealed class LikedVideosState extends Equatable {
  const LikedVideosState();

  @override
  List<Object?> get props => [];
}

final class LikedVideosInitial extends LikedVideosState {
  const LikedVideosInitial();
}

final class LikedVideosLoading extends LikedVideosState {
  const LikedVideosLoading();
}

final class LikedVideosLoaded extends LikedVideosState {
  final LikedVideosFeedEntity feed;

  const LikedVideosLoaded(this.feed);

  @override
  List<Object?> get props => [feed];
}

final class LikedVideosError extends LikedVideosState {
  final String message;

  const LikedVideosError(this.message);

  @override
  List<Object?> get props => [message];
}
