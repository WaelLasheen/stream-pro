import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/notifications_repository.dart';

class DeleteAllNotificationsUseCase {
  final NotificationsRepository repository;

  DeleteAllNotificationsUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.deleteAllNotifications();
  }
}

class DeleteNotificationUseCase {
  final NotificationsRepository repository;

  DeleteNotificationUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteNotification(id);
  }
}