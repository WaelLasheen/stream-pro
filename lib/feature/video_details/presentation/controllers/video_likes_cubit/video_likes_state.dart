import 'package:equatable/equatable.dart';

sealed class VideoLikesState extends Equatable {
  final bool isLiked;
  final int likesCount;

  const VideoLikesState({required this.isLiked, required this.likesCount});

  @override
  List<Object?> get props => [isLiked, likesCount];
}

final class VideoLikesInitial extends VideoLikesState {
  const VideoLikesInitial({required super.isLiked, required super.likesCount});
}

final class VideoLikesUpdated extends VideoLikesState {
  const VideoLikesUpdated({required super.isLiked, required super.likesCount});
}

final class VideoLikesFailure extends VideoLikesState {
  final String errorMessage;

  const VideoLikesFailure({
    required super.isLiked,
    required super.likesCount,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [isLiked, likesCount, errorMessage];
}