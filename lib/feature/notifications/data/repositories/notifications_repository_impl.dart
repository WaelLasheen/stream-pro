import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/paginated_notifications_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedNotificationsEntity>> getNotifications({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getNotifications(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> markAllNotificationsAsRead() {
    return safeCall(() async {
      await remoteDataSource.markAllNotificationsAsRead();
    });
  }

  @override
  Future<Either<Failure, void>> markNotificationAsRead(String id) {
    return safeCall(() async {
      await remoteDataSource.markNotificationAsRead(id);
    });
  }

  @override
  Future<Either<Failure, void>> deleteAllNotifications() {
    return safeCall(() async {
      await remoteDataSource.deleteAllNotifications();
    });
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String id) {
    return safeCall(() async {
      await remoteDataSource.deleteNotification(id);
    });
  }
}
