import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/channel_repository.dart';

class UploadChannelAvatarUseCase {
  final ChannelRepository repository;

  UploadChannelAvatarUseCase(this.repository);

  Future<Either<Failure, String>> call(String filePath) {
    return repository.uploadChannelAvatar(filePath);
  }
}