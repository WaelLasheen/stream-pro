import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_details_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_home_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/paginated_channel_playlists_entity.dart';
import 'package:stream_pro/feature/channel/domain/entities/paginated_channel_videos_entity.dart';
import '../../domain/repositories/channel_repository.dart';
import '../datasources/channel_remote_datasource.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelRemoteDataSource remoteDataSource;

  ChannelRepositoryImpl({required this.remoteDataSource});

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
