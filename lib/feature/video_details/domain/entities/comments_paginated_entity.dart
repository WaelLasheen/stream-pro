import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';

class CommentsPaginatedEntity extends Equatable {
  final List<CommentEntity> items;
  final int pageNumber;
  final int pageSize;

  const CommentsPaginatedEntity({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [items, pageNumber, pageSize];
}