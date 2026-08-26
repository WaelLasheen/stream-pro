import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/add_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/delete_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_comments_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/update_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_state.dart';

class VideoCommentsCubit extends Cubit<VideoCommentsState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  VideoCommentsCubit({
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
    required this.updateCommentUseCase,
    required this.deleteCommentUseCase,
  }) : super(VideoCommentsInitial());

  /// Fetch initial list of comments (First Page / Refresh)
  Future<void> fetchComments(String videoId) async {
    emit(VideoCommentsLoading());

    final result = await getCommentsUseCase(videoId: videoId, page: 1);

    result.fold((failure) => emit(VideoCommentsFailure(failure.message)), (
      paginatedEntity,
    ) {
      final hasMore = paginatedEntity.items.length >= paginatedEntity.pageSize;
      emit(
        VideoCommentsSuccess(
          comments: paginatedEntity.items,
          hasMorePages: hasMore,
          currentPage: 1,
        ),
      );
    });
  }

  /// Fetch next page for infinite scroll
  Future<void> fetchMoreComments(String videoId) async {
    final currentState = state;
    if (currentState is! VideoCommentsSuccess ||
        !currentState.hasMorePages ||
        currentState.isLoadingMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await getCommentsUseCase(videoId: videoId, page: nextPage);

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (paginatedEntity) {
        final updatedList = List<CommentEntity>.from(currentState.comments)
          ..addAll(paginatedEntity.items);
        final hasMore =
            paginatedEntity.items.length >= paginatedEntity.pageSize;

        emit(
          currentState.copyWith(
            comments: updatedList,
            hasMorePages: hasMore,
            currentPage: nextPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<bool> addComment(String videoId, String content) async {
    final currentState = state;
    if (currentState is VideoCommentsSuccess) {
      emit(currentState.copyWith(isSubmitting: true));
    }

    final result = await addCommentUseCase(videoId: videoId, content: content);

    return result.fold(
      (failure) {
        if (currentState is VideoCommentsSuccess) {
          emit(currentState.copyWith(isSubmitting: false));
        }
        return false;
      },
      (newComment) {
        if (currentState is VideoCommentsSuccess) {
          final updated = [newComment, ...currentState.comments];
          emit(currentState.copyWith(comments: updated, isSubmitting: false));
        } else {
          emit(
            VideoCommentsSuccess(
              comments: [newComment],
              hasMorePages: false,
              currentPage: 1,
            ),
          );
        }
        return true;
      },
    );
  }

  Future<bool> updateComment(String commentId, String newContent) async {
    final currentState = state;
    if (currentState is! VideoCommentsSuccess) return false;

    emit(currentState.copyWith(isSubmitting: true));

    final result = await updateCommentUseCase(
      commentId: commentId,
      content: newContent,
    );

    return result.fold(
      (failure) {
        emit(currentState.copyWith(isSubmitting: false));
        return false;
      },
      (updatedComment) {
        final updatedList = currentState.comments.map((comment) {
          return comment.commentId == commentId ? updatedComment : comment;
        }).toList();

        emit(currentState.copyWith(comments: updatedList, isSubmitting: false));
        return true;
      },
    );
  }

  Future<bool> deleteComment(String commentId) async {
    final currentState = state;
    if (currentState is! VideoCommentsSuccess) return false;

    final result = await deleteCommentUseCase(commentId);

    return result.fold((failure) => false, (_) {
      final updatedList = currentState.comments
          .where((comment) => comment.commentId != commentId)
          .toList();

      emit(currentState.copyWith(comments: updatedList));
      return true;
    });
  }
}
