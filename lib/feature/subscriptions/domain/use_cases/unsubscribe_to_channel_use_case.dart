import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/subscriptions_repository.dart';

class UnsubscribeToChannelUseCase {
  final SubscriptionsRepository repository;

  UnsubscribeToChannelUseCase(this.repository);

  Future<Either<Failure, void>> call(String channelId) {
    return repository.unsubscribeToChannel(channelId);
  }
}
