import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_notifications_entity.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<Either<Failure, PaginatedNotificationsEntity>> call({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return repository.getNotifications(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
