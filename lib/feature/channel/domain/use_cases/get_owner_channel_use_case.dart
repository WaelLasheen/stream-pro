import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/owner_channel_entity.dart';
import '../repositories/channel_repository.dart';

class GetOwnerChannelUseCase {
  final ChannelRepository repository;

  GetOwnerChannelUseCase(this.repository);

  Future<Either<Failure, OwnerChannelEntity>> call() {
    return repository.getOwnerChannel();
  }
}