import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/channel_details_entity.dart';
import '../repositories/channel_repository.dart';

class GetChannelDetailsUseCase {
  final ChannelRepository repository;

  GetChannelDetailsUseCase(this.repository);

  Future<Either<Failure, ChannelDetailsEntity>> call(String channelId) {
    return repository.getChannelDetails(channelId);
  }
}