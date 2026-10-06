import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';

class UpdateChannelInfoUseCase {
  final OwnerChannelRepository repository;

  UpdateChannelInfoUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String title,
    required String description,
  }) {
    return repository.updateChannelInfo(title: title, description: description);
  }
}
