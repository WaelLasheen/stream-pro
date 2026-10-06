import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_notifications_entity.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, PaginatedNotificationsEntity>> getNotifications({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, void>> markAllNotificationsAsRead();

  Future<Either<Failure, void>> markNotificationAsRead(String id);

  Future<Either<Failure, void>> deleteAllNotifications();

  Future<Either<Failure, void>> deleteNotification(String id);
}