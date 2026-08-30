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

  @override
  List<Object?> get props => [items, pageNumber, pageSize, totalCount, totalPages, hasNextPage];
}