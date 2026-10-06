import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/paginated_subscriptions_entity.dart';
import '../../domain/repositories/subscriptions_repository.dart';
import '../datasources/subscriptions_remote_datasource.dart';

class SubscriptionsRepositoryImpl implements SubscriptionsRepository {
  final SubscriptionsRemoteDataSource remoteDataSource;

  SubscriptionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> subscribeToChannel(String channelId) {
    return safeCall(() => remoteDataSource.subscribeToChannel(channelId));
  }

  @override
  Future<Either<Failure, void>> unsubscribeToChannel(String channelId) {
    return safeCall(() => remoteDataSource.unsubscribeToChannel(channelId));
  }

  @override
  Future<Either<Failure, PaginatedSubscriptionsEntity>> getSubscriptions({
    List<String> cursor = const [],
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getSubscriptions(cursor: cursor);
      return model.toEntity();
    });
  }
}
