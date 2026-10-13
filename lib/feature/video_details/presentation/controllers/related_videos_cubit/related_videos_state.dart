part of 'related_videos_cubit.dart';

sealed class RelatedVideosState extends Equatable {
  const RelatedVideosState();

  @override
  List<Object> get props => [];
}

final class RelatedVideosInitial extends RelatedVideosState {}

final class RelatedVideosLoading extends RelatedVideosState {}

final class RelatedVideosLoaded extends RelatedVideosState {
  final List<RelatedVideoEntity> videos;

  const RelatedVideosLoaded({required this.videos});
}

final class RelatedVideosFailure extends RelatedVideosState {
  final String message;

  const RelatedVideosFailure({required this.message});
  @override
  List<Object> get props => [message];
}
