import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/channel_repository.dart';

class UploadChannelThumbnailUseCase {
  final ChannelRepository repository;

  UploadChannelThumbnailUseCase(this.repository);

  Future<Either<Failure, String>> call(String filePath) {
    return repository.uploadChannelThumbnail(filePath);
  }
}