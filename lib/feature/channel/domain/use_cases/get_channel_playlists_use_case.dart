import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_channel_playlists_entity.dart';
import '../repositories/channel_repository.dart';

class GetChannelPlaylistsUseCase {
  final ChannelRepository repository;

  GetChannelPlaylistsUseCase(this.repository);

  Future<Either<Failure, PaginatedChannelPlaylistsEntity>> call(
    String channelId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return repository.getChannelPlaylists(channelId, pageNumber: pageNumber, pageSize: pageSize);
  }
}