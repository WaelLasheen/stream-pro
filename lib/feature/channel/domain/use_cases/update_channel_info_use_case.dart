import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/channel/domain/repositories/channel_repository.dart';

class UpdateChannelInfoUseCase {
  final ChannelRepository repository;

  UpdateChannelInfoUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String title,
    required String description,
  }) {
    return repository.updateChannelInfo(title: title, description: description);
  }
}
