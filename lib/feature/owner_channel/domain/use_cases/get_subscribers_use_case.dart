import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';
import '../entities/paginated_subscribers_entity.dart';

class GetSubscribersUseCase {
  final OwnerChannelRepository repository;

  GetSubscribersUseCase(this.repository);

  Future<Either<Failure, PaginatedSubscribersEntity>> call({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return repository.getSubscribers(pageNumber: pageNumber, pageSize: pageSize);
  }
}
