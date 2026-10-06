import 'package:equatable/equatable.dart';
import 'owner_video_entity.dart';

class PaginatedOwnerVideosEntity extends Equatable {
  final List<OwnerVideoEntity> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedOwnerVideosEntity({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
  });

  PaginatedOwnerVideosEntity copyWith({
    List<OwnerVideoEntity>? items,
    int? pageNumber,
    int? pageSize,
    int? totalCount,
    int? totalPages,
    bool? hasNextPage,
  }) {
    return PaginatedOwnerVideosEntity(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    items,
    pageNumber,
    pageSize,
    totalCount,
    totalPages,
    hasNextPage,
  ];
}
