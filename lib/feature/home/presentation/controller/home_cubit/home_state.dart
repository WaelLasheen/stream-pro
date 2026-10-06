import 'package:equatable/equatable.dart';
import '../../../domain/entities/video_entity.dart';

sealed class HomeState extends Equatable {
  final List<VideoEntity> videos;
  const HomeState({this.videos = const []});

  @override
  List<Object?> get props => [videos];
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  final bool hasReachedMax;
  final bool isLoadingMore;

  const HomeLoadedState({
    required super.videos,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  HomeLoadedState copyWith({
    List<VideoEntity>? videos,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return HomeLoadedState(
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [videos, hasReachedMax, isLoadingMore];
}

class HomeErrorState extends HomeState {
  final String message;
  const HomeErrorState({required super.videos, required this.message});

  @override
  List<Object?> get props => [videos, message];
}
