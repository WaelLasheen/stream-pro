import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_subscriptions_entity.dart';

abstract class SubscriptionsRepository {
  Future<Either<Failure, void>> subscribeToChannel(String channelId);
  Future<Either<Failure, void>> unsubscribeToChannel(String channelId);
  Future<Either<Failure, PaginatedSubscriptionsEntity>> getSubscriptions({
    List<String> cursor = const [],
  });
}
