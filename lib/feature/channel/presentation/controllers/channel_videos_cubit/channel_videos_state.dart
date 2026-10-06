import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_channel_videos_entity.dart';

sealed class ChannelVideosState extends Equatable {
  final PaginatedChannelVideosEntity? videos;

  const ChannelVideosState({this.videos});

  @override
  List<Object?> get props => [videos];
}

class ChannelVideosInitialState extends ChannelVideosState {
  const ChannelVideosInitialState();
}

class ChannelVideosLoadingState extends ChannelVideosState {
  const ChannelVideosLoadingState();
}

class ChannelVideosLoadedState extends ChannelVideosState {
  final bool isLoadingMore;

  const ChannelVideosLoadedState({
    required PaginatedChannelVideosEntity super.videos,
    this.isLoadingMore = false,
  });

  ChannelVideosLoadedState copyWith({
    PaginatedChannelVideosEntity? videos,
    bool? isLoadingMore,
  }) {
    return ChannelVideosLoadedState(
      videos: videos ?? this.videos!,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [videos, isLoadingMore];
}

class ChannelVideosErrorState extends ChannelVideosState {
  final String message;

  const ChannelVideosErrorState({required this.message, super.videos});

  @override
  List<Object?> get props => [message, videos];
}
