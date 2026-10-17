import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/update_comment_use_case.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_state.dart.dart';
import '../../params/user_params.dart';
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
    UserParams user,
  ) async {
    final currentState = state;
    final currentComments = state.comments;
    if (currentComments == null) return;
    if (currentState is CommentsLoaded && currentState.isSubmitting) return;

    final optimisticComment = CommentEntity.temp(
      videoId: videoId,
      content: content,
      userId: user.userId,
      userName: user.userName,
      userProfileImage: user.userProfileImage,
    );

    final updatedItems = [
      optimisticComment,
      ...currentState.comments!.comments,
    ];
    emit(
      CommentsLoaded(
        comments: currentComments.copyWith(comments: updatedItems),
        isSubmitting: true,
      ),
    );

    final result = await addCommentUseCase(videoId: videoId, content: content);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        CommentsError(
          comments: currentState.comments,
          message: failure.message,
        ),
      ),
      (commentId) {
        final realUpdatedComments = updatedItems.map((item) {
          return item.commentId.startsWith('temp_')
              ? item.copyWith(commentId: commentId)
              : item;
        }).toList();

        emit(
          CommentsLoaded(
            comments: currentComments.copyWith(comments: realUpdatedComments),
            isSubmitting: false,
          ),
        );
      },
    );
  }

  Future<void> updateComment(String commentId, String content) async {
    final currentState = state;
    final currentComments = currentState.comments;
    if (currentComments == null) return;
    if (currentState is CommentsLoaded && currentState.isSubmitting) return;

    final optimistic = currentComments.comments
        .map(
          (c) => (c.commentId == commentId)
              ? c.copyWith(content: content, isEdited: true)
              : c,
        )
        .toList();

    emit(
      CommentsLoaded(
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
      (failure) => emit(
        CommentsError(
          comments: currentState.comments,
          message: failure.message,
        ),
      ),
      (updatedComment) => emit(
        CommentsLoaded(
          comments: currentComments.copyWith(comments: optimistic),
          isSubmitting: false,
        ),
      ),
    );
  }

  Future<void> deleteComment(String commentId) async {
    final currentState = state;
    final currentComments = currentState.comments;
    if (currentComments == null) return;
    if (currentState is CommentsLoaded && currentState.isSubmitting) return;

    final optimistic = currentComments.comments
        .where((c) => c.commentId != commentId)
        .toList();
    emit(
      CommentsLoaded(
        comments: currentComments.copyWith(comments: optimistic),
        isSubmitting: true,
      ),
    );

    final result = await deleteCommentUseCase(commentId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        CommentsError(
          comments: currentState.comments,
          message: failure.message,
        ),
      ),
      (success) => emit(
        CommentsLoaded(
          comments: currentComments.copyWith(comments: optimistic),
          isSubmitting: false,
        ),
      ),
    );
  }

  void incrementReplyCount(String commentId) {
    final currentComments = state.comments;
    if (currentComments == null) return;

    final updatedComments = currentComments.comments.map((c) {
      if (c.commentId == commentId) {
        return c.copyWith(replyCount: c.replyCount + 1);
      }
      return c;
    }).toList();

    emit(
      CommentsLoaded(
        comments: currentComments.copyWith(comments: updatedComments),
      ),
    );
  }

  void decrementReplyCount(String commentId) {
    final currentComments = state.comments;
    if (currentComments == null) return;
    final updatedComments = currentComments.comments.map((c) {
      if (c.commentId == commentId && c.replyCount > 0) {
        return c.copyWith(replyCount: c.replyCount - 1);
      }
      return c;
    }).toList();

    emit(
      CommentsLoaded(
        comments: currentComments.copyWith(comments: updatedComments),
      ),
    );
  }
}
