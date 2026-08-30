import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/owner_channel_entity.dart';
import '../entities/channel_details_entity.dart';
import '../entities/channel_home_entity.dart';
import '../entities/paginated_channel_videos_entity.dart';
import '../entities/paginated_channel_playlists_entity.dart';

abstract class ChannelRepository {
  Future<Either<Failure, OwnerChannelEntity>> getOwnerChannel();
  Future<Either<Failure, OwnerChannelEntity>> createOwnerChannel();
  Future<Either<Failure, void>> updateChannelInfo({required String title, required String description});
  Future<Either<Failure, String>> uploadChannelAvatar(String filePath);
  Future<Either<Failure, String>> uploadChannelThumbnail(String filePath);
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
