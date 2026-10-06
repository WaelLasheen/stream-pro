import 'package:equatable/equatable.dart';
import 'channel_playlist_entity.dart';

class PaginatedChannelPlaylistsEntity extends Equatable {
  final List<ChannelPlaylistEntity> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;

  const PaginatedChannelPlaylistsEntity({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
  });

  PaginatedChannelPlaylistsEntity copyWith({
    List<ChannelPlaylistEntity>? items,
    int? pageNumber,
    int? pageSize,
    int? totalCount,
    int? totalPages,
    bool? hasNextPage,
  }) {
    return PaginatedChannelPlaylistsEntity(
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
