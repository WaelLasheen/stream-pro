import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/add_comment_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/delete_comment_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/get_replies_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/update_comment_use_case.dart';
import '../../params/user_params.dart';
import 'replies_state.dart';

class RepliesCubit extends Cubit<RepliesState> {
  final GetRepliesUseCase getRepliesUseCase;
  final AddCommentUseCase addCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  RepliesCubit({
    required this.getRepliesUseCase,
    required this.addCommentUseCase,
    required this.updateCommentUseCase,
    required this.deleteCommentUseCase,
  }) : super(const RepliesState());

  void toggleExpanded(String parentId, {required int replyCount}) {
    final expanded = Set<String>.from(state.expandedParentIds);
    if (expanded.contains(parentId)) {
      expanded.remove(parentId);
      emit(state.copyWith(expandedParentIds: expanded));
    } else {
      expanded.add(parentId);
      emit(state.copyWith(expandedParentIds: expanded));

      // Lazy-fetch on first expand when replies exist but not loaded yet.
      if (replyCount > 0 &&
          !state.hasData(parentId) &&
          !state.isLoading(parentId)) {
        fetchReplies(parentId);
      }
    }
  }

  Future<void> fetchReplies(String parentId, {bool force = false}) async {
    if (state.isLoading(parentId)) return;
    if (!force && state.hasData(parentId)) return;

    final loading = {...state.loadingParentIds, parentId};
    final errors = {...state.errorByParent}..remove(parentId);
    emit(state.copyWith(loadingParentIds: loading, errorByParent: errors));

    final result = await getRepliesUseCase(parentId);
    if (isClosed) return;

    result.fold(
      (failure) {
        final nextLoading = state.loadingParentIds
            .where((id) => id != parentId)
            .toSet();
        final nextErrors = {...state.errorByParent, parentId: failure.message};
        emit(
          state.copyWith(
            loadingParentIds: nextLoading,
            errorByParent: nextErrors,
          ),
        );
      },
      (replies) {
        final nextLoading = state.loadingParentIds
            .where((id) => id != parentId)
            .toSet();
        final nextMap = {...state.repliesByParent, parentId: replies};
        final nextErrors = {...state.errorByParent}..remove(parentId);
        emit(
          state.copyWith(
            loadingParentIds: nextLoading,
            repliesByParent: nextMap,
            errorByParent: nextErrors,
          ),
        );
      },
    );
  }

  Future<void> addReply({
    required String videoId,
    required String parentId,
    required String content,
    required UserParams user,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    if (content.trim().isEmpty || state.isSubmitting(parentId)) return;

    final currentReplies = state.repliesOf(parentId);
    final optimistic = CommentEntity.temp(
      videoId: videoId,
      content: content.trim(),
      userId: user.userId,
      userName: user.userName,
      userProfileImage: user.userProfileImage,
    );

    // Optimistic Add
    final updatedReplies = [optimistic, ...currentReplies];
    emit(
      state.copyWith(
        repliesByParent: {...state.repliesByParent, parentId: updatedReplies},
        submittingParentIds: {...state.submittingParentIds, parentId},
        expandedParentIds: {...state.expandedParentIds, parentId},
      ),
    );
    onSuccess();

    final result = await addCommentUseCase(
      videoId: videoId,
      content: content.trim(),
      parentId: parentId,
    );
    if (isClosed) return;

    result.fold(
      (failure) {
        onFailure();
        emit(
          state.copyWith(
            repliesByParent: {
              ...state.repliesByParent,
              parentId: currentReplies,
            },
            submittingParentIds: state.submittingParentIds
                .where((id) => id != parentId)
                .toSet(),
            errorByParent: {...state.errorByParent, parentId: failure.message},
            lastErrorMessage: failure.message,
          ),
        );
      },
      (commentId) {
        final realUpdatedReplies = updatedReplies.map((item) {
          return item.commentId == optimistic.commentId
              ? item.copyWith(commentId: commentId)
              : item;
        }).toList();

        emit(
          state.copyWith(
            repliesByParent: {
              ...state.repliesByParent,
              parentId: realUpdatedReplies,
            },
            submittingParentIds: state.submittingParentIds
                .where((id) => id != parentId)
                .toSet(),
            errorByParent: {...state.errorByParent}..remove(parentId),
            lastErrorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> updateReply({
    required String parentId,
    required String commentId,
    required String content,
  }) async {
    if (content.trim().isEmpty || state.isMutating(commentId)) return;

    final currentReplies = state.repliesOf(parentId);
    final index = currentReplies.indexWhere((e) => e.commentId == commentId);
    if (index == -1) return;

    // Optimistic Update
    final optimisticReplies = currentReplies.map((c) {
      return c.commentId == commentId
          ? c.copyWith(content: content.trim(), isEdited: true)
          : c;
    }).toList();

    emit(
      state.copyWith(
        repliesByParent: {
          ...state.repliesByParent,
          parentId: optimisticReplies,
        },
        mutatingCommentIds: {...state.mutatingCommentIds, commentId},
      ),
    );

    final result = await updateCommentUseCase(
      commentId: commentId,
      content: content.trim(),
      parentId: parentId,
    );
    if (isClosed) return;

    result.fold(
      (failure) {
        // Rollback on failure
        emit(
          state.copyWith(
            repliesByParent: {
              ...state.repliesByParent,
              parentId: currentReplies,
            },
            mutatingCommentIds: state.mutatingCommentIds
                .where((id) => id != commentId)
                .toSet(),
            errorByParent: {...state.errorByParent, parentId: failure.message},
            lastErrorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            mutatingCommentIds: state.mutatingCommentIds
                .where((id) => id != commentId)
                .toSet(),
            errorByParent: {...state.errorByParent}..remove(parentId),
            lastErrorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> deleteReply({
    required String parentId,
    required String commentId,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    if (state.isMutating(commentId)) return;

    final currentReplies = state.repliesOf(parentId);
    final index = currentReplies.indexWhere((e) => e.commentId == commentId);
    if (index == -1) return;

    // Optimistic Delete
    final optimisticReplies = currentReplies
        .where((c) => c.commentId != commentId)
        .toList();

    emit(
      state.copyWith(
        repliesByParent: {
          ...state.repliesByParent,
          parentId: optimisticReplies,
        },
        mutatingCommentIds: {...state.mutatingCommentIds, commentId},
      ),
    );
    onSuccess();

    final result = await deleteCommentUseCase(commentId);
    if (isClosed) return;

    result.fold(
      (failure) {
        onFailure();
        emit(
          state.copyWith(
            repliesByParent: {
              ...state.repliesByParent,
              parentId: currentReplies,
            },
            mutatingCommentIds: state.mutatingCommentIds
                .where((id) => id != commentId)
                .toSet(),
            errorByParent: {...state.errorByParent, parentId: failure.message},
            lastErrorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            mutatingCommentIds: state.mutatingCommentIds
                .where((id) => id != commentId)
                .toSet(),
            errorByParent: {...state.errorByParent}..remove(parentId),
            lastErrorMessage: null,
          ),
        );
      },
    );
  }
}
