import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_comments_entity.dart';

sealed class CommentsState extends Equatable {
  final PaginatedCommentsEntity? comments;
  const CommentsState({this.comments});

  @override
  List<Object?> get props => [comments];
}

class CommentsInitial extends CommentsState {
  const CommentsInitial();
}

class CommentsLoading extends CommentsState {
  const CommentsLoading();
}

class CommentsLoaded extends CommentsState {
  final bool isLoadingMore;
  final bool isSubmitting;

  const CommentsLoaded({
    required PaginatedCommentsEntity super.comments,
    this.isLoadingMore = false,
    this.isSubmitting = false,
  });

  CommentsLoaded copyWith({
    PaginatedCommentsEntity? comments,
    bool? isLoadingMore,
    bool? isSubmitting,
  }) {
    return CommentsLoaded(
      comments: comments ?? this.comments!,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [comments, isLoadingMore, isSubmitting];
}

class CommentsError extends CommentsState {
  final String message;
  const CommentsError({required this.message, super.comments});

  @override
  List<Object?> get props => [message, comments];
}
