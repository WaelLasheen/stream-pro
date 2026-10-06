import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/paginated_subscribers_entity.dart';
import '../entities/owner_channel_entity.dart';
import '../entities/owner_playlist_entity.dart';
import '../entities/paginated_owner_videos_entity.dart';

abstract class OwnerChannelRepository {
  Future<Either<Failure, OwnerChannelEntity>> getOwnerChannel();
  Future<Either<Failure, void>> createOwnerChannel();
  Future<Either<Failure, void>> updateChannelInfo({
    required String title,
    required String description,
  });
  Future<Either<Failure, String>> uploadChannelAvatar(String filePath);
  Future<Either<Failure, String>> uploadChannelThumbnail(String filePath);

  Future<Either<Failure, PaginatedOwnerVideosEntity>> getOwnerVideos({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, List<OwnerPlaylistEntity>>> getOwnerPlaylists();
  Future<Either<Failure, PaginatedSubscribersEntity>> getSubscribers({
    int pageNumber = 1,
    int pageSize = 10,
  });
}
