import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';

class CreateOwnerChannelUseCase {
  final OwnerChannelRepository repository;

  CreateOwnerChannelUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.createOwnerChannel();
  }
}
