import 'package:equatable/equatable.dart';
import 'search_video_entity.dart';

class PaginatedSearchResultEntity extends Equatable {
  final List<SearchVideoEntity> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;

  const PaginatedSearchResultEntity({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
  });

  PaginatedSearchResultEntity copyWith({
    List<SearchVideoEntity>? items,
    int? pageNumber,
  }) {
    return PaginatedSearchResultEntity(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    items,
    pageNumber,
    pageSize,
    totalCount,
    hasNextPage,
  ];
}
