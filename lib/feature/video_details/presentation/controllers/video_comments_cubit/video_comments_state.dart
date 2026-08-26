import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';

sealed class VideoCommentsState extends Equatable {
  const VideoCommentsState();

  @override
  List<Object?> get props => [];
}

final class VideoCommentsInitial extends VideoCommentsState {}

final class VideoCommentsLoading extends VideoCommentsState {}

final class VideoCommentsSuccess extends VideoCommentsState {
  final List<CommentEntity> comments;
  final bool hasMorePages;
  final int currentPage;
  final bool isSubmitting;
  final bool isLoadingMore;

  const VideoCommentsSuccess({
    required this.comments,
    required this.hasMorePages,
    required this.currentPage,
    this.isSubmitting = false,
    this.isLoadingMore = false,
  });

  VideoCommentsSuccess copyWith({
    List<CommentEntity>? comments,
    bool? hasMorePages,
    int? currentPage,
    bool? isSubmitting,
    bool? isLoadingMore,
  }) {
    return VideoCommentsSuccess(
      comments: comments ?? this.comments,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      currentPage: currentPage ?? this.currentPage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    comments,
    hasMorePages,
    currentPage,
    isSubmitting,
    isLoadingMore,
  ];
}

final class VideoCommentsFailure extends VideoCommentsState {
  final String errorMessage;

  const VideoCommentsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
