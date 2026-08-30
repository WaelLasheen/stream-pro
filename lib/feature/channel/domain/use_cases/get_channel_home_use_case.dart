import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/channel_home_entity.dart';
import '../repositories/channel_repository.dart';

class GetChannelHomeUseCase {
  final ChannelRepository repository;

  GetChannelHomeUseCase(this.repository);

  Future<Either<Failure, ChannelHomeEntity>> call(String channelId) {
    return repository.getChannelHome(channelId);
  }
}