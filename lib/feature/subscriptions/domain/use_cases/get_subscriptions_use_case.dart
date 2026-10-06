import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_subscriptions_entity.dart';
import '../repositories/subscriptions_repository.dart';

class GetSubscriptionsUseCase {
  final SubscriptionsRepository repository;

  GetSubscriptionsUseCase(this.repository);

  Future<Either<Failure, PaginatedSubscriptionsEntity>> call({
    List<String> cursor = const [],
  }) {
    return repository.getSubscriptions();
  }
}
