import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';

class RepliesState extends Equatable {
  final Map<String, List<CommentEntity>> repliesByParent;
  final Set<String> loadingParentIds;
  final Map<String, String> errorByParent;
  final Set<String> expandedParentIds;
  final Set<String> submittingParentIds;
  final Set<String> mutatingCommentIds;
  final String? lastErrorMessage;

  const RepliesState({
    this.repliesByParent = const {},
    this.loadingParentIds = const {},
    this.errorByParent = const {},
    this.expandedParentIds = const {},
    this.submittingParentIds = const {},
    this.mutatingCommentIds = const {},
    this.lastErrorMessage,
  });

  // Helpers
  bool isExpanded(String parentId) => expandedParentIds.contains(parentId);
  bool isLoading(String parentId) => loadingParentIds.contains(parentId);
  bool isSubmitting(String parentId) => submittingParentIds.contains(parentId);
  bool isMutating(String commentId) => mutatingCommentIds.contains(commentId);
  bool hasData(String parentId) => repliesByParent.containsKey(parentId);
  bool hasError(String parentId) => errorByParent.containsKey(parentId);

  List<CommentEntity> repliesOf(String parentId) =>
      repliesByParent[parentId] ?? const [];
  String? errorOf(String parentId) => errorByParent[parentId];

  RepliesState copyWith({
    Map<String, List<CommentEntity>>? repliesByParent,
    Set<String>? loadingParentIds,
    Map<String, String>? errorByParent,
    Set<String>? expandedParentIds,
    Set<String>? submittingParentIds,
    Set<String>? mutatingCommentIds,
    String? lastErrorMessage,
  }) {
    return RepliesState(
      repliesByParent: repliesByParent ?? this.repliesByParent,
      loadingParentIds: loadingParentIds ?? this.loadingParentIds,
      errorByParent: errorByParent ?? this.errorByParent,
      expandedParentIds: expandedParentIds ?? this.expandedParentIds,
      submittingParentIds: submittingParentIds ?? this.submittingParentIds,
      mutatingCommentIds: mutatingCommentIds ?? this.mutatingCommentIds,
      lastErrorMessage: lastErrorMessage ?? this.lastErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    repliesByParent,
    loadingParentIds,
    errorByParent,
    expandedParentIds,
    submittingParentIds,
    mutatingCommentIds,
    lastErrorMessage,
  ];
}
