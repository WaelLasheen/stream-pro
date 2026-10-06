import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';
import '../entities/owner_channel_entity.dart';

class GetOwnerChannelUseCase {
  final OwnerChannelRepository repository;

  GetOwnerChannelUseCase(this.repository);

  Future<Either<Failure, OwnerChannelEntity>> call() {
    return repository.getOwnerChannel();
  }
}