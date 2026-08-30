import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_details_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_home_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/paginated_channel_playlists_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/paginated_channel_videos_entity.dart';
import '../../domain/repositories/channel_repository.dart';
import '../datasources/channel_remote_datasource.dart';
// ... entities & models imports ...

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelRemoteDataSource remoteDataSource;

  ChannelRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OwnerChannelEntity>> getOwnerChannel() {
    return safeCall(() async {
      final model = await remoteDataSource.getOwnerChannel();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, OwnerChannelEntity>> createOwnerChannel() {
    return safeCall(() async {
      final model = await remoteDataSource.createOwnerChannel();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> updateChannelInfo({
    required String title,
    required String description,
  }) {
    return safeCall(() async {
      await remoteDataSource.updateChannelInfo(
        title: title,
        description: description,
      );
    });
  }

  @override
  Future<Either<Failure, String>> uploadChannelAvatar(String filePath) {
    return safeCall(() => remoteDataSource.uploadChannelAvatar(filePath));
  }

  @override
  Future<Either<Failure, String>> uploadChannelThumbnail(String filePath) {
    return safeCall(() => remoteDataSource.uploadChannelThumbnail(filePath));
  }

  @override
  Future<Either<Failure, ChannelDetailsEntity>> getChannelDetails(
    String channelId,
  ) {
    return safeCall(() async {
      final model = await remoteDataSource.getChannelDetails(channelId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ChannelHomeEntity>> getChannelHome(String channelId) {
    return safeCall(() async {
      final model = await remoteDataSource.getChannelHome(channelId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, PaginatedChannelVideosEntity>> getChannelVideos(
    String channelId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getChannelVideos(
        channelId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, PaginatedChannelPlaylistsEntity>> getChannelPlaylists(
    String channelId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getChannelPlaylists(
        channelId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return model.toEntity();
    });
  }
}
