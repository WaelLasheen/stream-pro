import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';

class PaginatedCommentsEntity extends Equatable {
  final List<CommentEntity> comments;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedCommentsEntity({
    required this.comments,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
  });

  PaginatedCommentsEntity copyWith({
    List<CommentEntity>? comments,
    int? pageNumber,
    int? pageSize,
    int? totalPages,
    bool? hasNextPage,
  }) {
    return PaginatedCommentsEntity(
      comments: comments ?? this.comments,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    comments,
    pageNumber,
    pageSize,
    totalPages,
    hasNextPage,
  ];
}
