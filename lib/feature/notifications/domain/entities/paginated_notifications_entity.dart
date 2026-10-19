import 'package:equatable/equatable.dart';
import 'notification_item_entity.dart';

class PaginatedNotificationsEntity extends Equatable {
  final List<NotificationItemEntity> items;
  final int pageSize;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasNextPage;
  final int unreadTotal;

  const PaginatedNotificationsEntity({
    required this.items,
    required this.pageSize,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasNextPage,
    required this.unreadTotal,
  });

  PaginatedNotificationsEntity copyWith({
    List<NotificationItemEntity>? items,
    int? pageSize,
    int? pageNumber,
    int? totalPages,
    int? totalCount,
    bool? hasNextPage,
    int? unreadTotal,
  }) {
    return PaginatedNotificationsEntity(
      items: items ?? this.items,
      pageSize: pageSize ?? this.pageSize,
      pageNumber: pageNumber ?? this.pageNumber,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      unreadTotal: unreadTotal ?? this.unreadTotal,
    );
  }

  @override
  List<Object?> get props => [
    items,
    pageSize,
    pageNumber,
    totalPages,
    totalCount,
    hasNextPage,
    unreadTotal,
  ];
}
