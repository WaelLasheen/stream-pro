import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_channel_videos_entity.dart';
import '../repositories/channel_repository.dart';

class GetChannelVideosUseCase {
  final ChannelRepository repository;

  GetChannelVideosUseCase(this.repository);

  Future<Either<Failure, PaginatedChannelVideosEntity>> call(
    String channelId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return repository.getChannelVideos(channelId, pageNumber: pageNumber, pageSize: pageSize);
  }
}