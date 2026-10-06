import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_owner_videos_entity.dart';

sealed class OwnerVideosState extends Equatable {
  final PaginatedOwnerVideosEntity? videos;

  const OwnerVideosState({this.videos});

  @override
  List<Object?> get props => [videos];
}

class OwnerVideosInitialState extends OwnerVideosState {
  const OwnerVideosInitialState();
}

class OwnerVideosLoadingState extends OwnerVideosState {
  const OwnerVideosLoadingState();
}

class OwnerVideosLoadedState extends OwnerVideosState {
  final bool isLoadingMore;

  const OwnerVideosLoadedState({
    required PaginatedOwnerVideosEntity super.videos,
    this.isLoadingMore = false,
  });

  OwnerVideosLoadedState copyWith({
    PaginatedOwnerVideosEntity? videos,
    bool? isLoadingMore,
  }) {
    return OwnerVideosLoadedState(
      videos: videos ?? this.videos!,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [videos, isLoadingMore];
}

class OwnerVideosErrorState extends OwnerVideosState {
  final String message;

  const OwnerVideosErrorState({required this.message, super.videos});

  @override
  List<Object?> get props => [message, videos];
}
