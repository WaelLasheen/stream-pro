import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/home/domain/entities/video_entity.dart';

class PaginatedChannelVideosEntity extends Equatable {
  final List<VideoEntity> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedChannelVideosEntity({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
  });

  @override
  List<Object?> get props => [items, pageNumber, pageSize, totalCount, totalPages, hasNextPage];
}