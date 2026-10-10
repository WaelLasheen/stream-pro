import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/update_comment_use_case.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_state.dart.dart';
import '../../../domain/use_cases/add_comment_use_case.dart';
import '../../../domain/use_cases/delete_comment_use_case.dart';
import '../../../domain/use_cases/get_comments_use_case.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;

  CommentsCubit({
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
    required this.deleteCommentUseCase,
    required this.updateCommentUseCase,
  }) : super(const CommentsInitial());

  Future<void> fetchComments(String videoID) async {
    emit(const CommentsLoading());

    final result = await getCommentsUseCase(videoId: videoID);
    if (isClosed) return;

    result.fold(
      (failure) => emit(CommentsError(message: failure.message)),
      (comments) => emit(CommentsLoaded(comments: comments)),
    );
  }

  Future<void> loadMoreComments(String videoId) async {
    final currentState = state;
    final currentComments = currentState.comments;

    if (currentComments == null || !currentComments.hasNextPage) return;
    if (currentState is CommentsLoaded && currentState.isLoadingMore) return;

    emit(CommentsLoaded(isLoadingMore: true, comments: currentComments));

    final result = await getCommentsUseCase(
      videoId: videoId,
      page: currentComments.pageNumber + 1,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        CommentsError(message: failure.message, comments: currentComments),
      ),
      (newComments) => emit(
        CommentsLoaded(
          comments: newComments.copyWith(
            comments: {
              ...currentComments.comments,
              ...newComments.comments,
            }.toList(),
          ),
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<void> addComment(
    String videoId,
    String content,
    // UserParams user,
  ) async {
    final currentState = state;
    if (currentState is! CommentsLoaded) return;

    final optimisticComment = CommentEntity.temp(
      videoId: videoId,
      content: content,
      // userId: user.userId,
      // userName: user.userName,
      // userProfileImage: user.userProfileImage,
      userId: '',
      userName: '',
      userProfileImage: '',
    );

    final updatedItems = [
      optimisticComment,
      ...currentState.comments!.comments,
    ];
    emit(
      currentState.copyWith(
        comments: currentState.comments!.copyWith(comments: updatedItems),
        isSubmitting: true,
      ),
    );

    final result = await addCommentUseCase(videoId: videoId, content: content);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          comments: currentState.comments,
          isSubmitting: false,
        ),
      ),
      (commentId) {
        final realUpdatedComments = updatedItems.map((item) {
          return item.commentId.startsWith('temp_')
              ? item.copyWith(commentId: commentId, isEdited: false)
              : item;
        }).toList();

        emit(
          currentState.copyWith(
            comments: currentState.comments!.copyWith(
              comments: realUpdatedComments,
            ),
            isSubmitting: false,
          ),
        );
      },
    );
  }

  Future<void> updateComment(String commentId, String content) async {
    final currentState = state;
    final currentComments = currentState.comments;
    if (currentState is! CommentsLoaded || currentComments == null) return;

    final optimistic = currentComments.comments
        .map(
          (c) => (c.commentId == commentId) ? c.copyWith(content: content) : c,
        )
        .toList();

    emit(
      currentState.copyWith(
        comments: currentComments.copyWith(comments: optimistic),
        isSubmitting: true,
      ),
    );

    final result = await updateCommentUseCase(
      commentId: commentId,
      content: content,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(currentState),
      (updatedComment) => emit(
        currentState.copyWith(
          comments: currentComments.copyWith(comments: optimistic),
          isSubmitting: false,
        ),
      ),
    );
  }

  Future<void> deleteComment(String commentId) async {
    final currentState = state;
    final currentComments = currentState.comments;
    if (currentState is! CommentsLoaded || currentComments == null) return;

    final optimistic = currentComments.comments
        .where((c) => c.commentId != commentId)
        .toList();
    emit(
      currentState.copyWith(
        comments: currentComments.copyWith(comments: optimistic),
        isSubmitting: true,
      ),
    );

    final result = await deleteCommentUseCase(commentId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(currentState),
      (success) => emit(
        currentState.copyWith(
          comments: currentComments.copyWith(comments: optimistic),
          isSubmitting: false,
        ),
      ),
    );
  }
}
