import '../models/paginated_notifications_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<PaginatedNotificationsModel> getNotifications({
    required int pageNumber,
    required int pageSize,
  });

  Future<void> markAllNotificationsAsRead();

  Future<void> markNotificationAsRead(String id);

  Future<void> deleteAllNotifications();

  Future<void> deleteNotification(String id);
}