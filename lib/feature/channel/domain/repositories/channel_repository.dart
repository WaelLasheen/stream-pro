import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/channel_details_entity.dart';
import '../entities/channel_home_entity.dart';
import '../entities/paginated_channel_videos_entity.dart';
import '../entities/paginated_channel_playlists_entity.dart';

/// Public/general channel viewing — anyone can view any channel by id.
/// For managing your OWN channel, see `owner_channel`'s `OwnerChannelRepository`.
abstract class ChannelRepository {
  Future<Either<Failure, ChannelDetailsEntity>> getChannelDetails(
    String channelId,
  );
  Future<Either<Failure, ChannelHomeEntity>> getChannelHome(String channelId);
  Future<Either<Failure, PaginatedChannelVideosEntity>> getChannelVideos(
    String channelId, {
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<Either<Failure, PaginatedChannelPlaylistsEntity>> getChannelPlaylists(
    String channelId, {
    int pageNumber = 1,
    int pageSize = 10,
  });
}
