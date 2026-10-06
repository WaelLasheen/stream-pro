import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';

class UploadChannelAvatarUseCase {
  final OwnerChannelRepository repository;

  UploadChannelAvatarUseCase(this.repository);

  Future<Either<Failure, String>> call(String filePath) {
    return repository.uploadChannelAvatar(filePath);
  }
}