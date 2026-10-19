import '../../domain/entities/paginated_notifications_entity.dart';
import 'notification_item_model.dart';

class PaginatedNotificationsModel {
  final List<NotificationItemModel> items;
  final int pageSize;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasNextPage;
  final int unreadTotal;

  const PaginatedNotificationsModel({
    required this.items,
    required this.pageSize,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasNextPage,
    required this.unreadTotal,
  });

  factory PaginatedNotificationsModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return PaginatedNotificationsModel(
      items: rawItems
          .map(
            (item) =>
                NotificationItemModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      pageSize: json['pageSize'] as int? ?? 10,
      pageNumber: json['pageNumber'] as int? ?? 1,
      totalPages: json['totalPages'] as int? ?? 1,
      totalCount: json['totalCount'] as int? ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      unreadTotal: json['unreadTotal'] as int? ?? 0,
    );
  }

  PaginatedNotificationsEntity toEntity() {
    return PaginatedNotificationsEntity(
      items: items.map((e) => e.toEntity()).toList(),
      pageSize: pageSize,
      pageNumber: pageNumber,
      totalPages: totalPages,
      totalCount: totalCount,
      hasNextPage: hasNextPage,
      unreadTotal: unreadTotal,
    );
  }
}
