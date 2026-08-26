import 'package:stream_pro/feature/video_details/data/models/comment_model.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comments_paginated_entity.dart';

class CommentsResponseModel {
  final List<CommentModel> items;
  final int pageNumber;
  final int pageSize;

  CommentsResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
  });

  factory CommentsResponseModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List? ?? [];
    return CommentsResponseModel(
      items: rawItems.map((e) => CommentModel.fromJson(e as Map<String, dynamic>)).toList(),
      pageNumber: json['pageNumber'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
    );
  }

  CommentsPaginatedEntity toEntity() {
    return CommentsPaginatedEntity(
      items: items.map((e) => e.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}