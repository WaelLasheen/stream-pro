import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_playlist_entity.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/paginated_owner_videos_entity.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/paginated_subscribers_entity.dart';
import '../../domain/repositories/owner_channel_repository.dart';
import '../datasources/owner_channel_remote_datasource.dart';

class OwnerChannelRepositoryImpl implements OwnerChannelRepository {
  final OwnerChannelRemoteDataSource remoteDataSource;

  OwnerChannelRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OwnerChannelEntity>> getOwnerChannel() {
    return safeCall(() async {
      final model = await remoteDataSource.getOwnerChannel();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> createOwnerChannel() {
    return safeCall(remoteDataSource.createOwnerChannel);
  }

  @override
  Future<Either<Failure, void>> updateChannelInfo({
    required String title,
    required String description,
  }) {
    return safeCall(
      () async => await remoteDataSource.updateChannelInfo(
        title: title,
        description: description,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> uploadChannelAvatar(String filePath) {
    return safeCall(
      () async => await remoteDataSource.uploadChannelAvatar(filePath),
    );
  }

  @override
  Future<Either<Failure, String>> uploadChannelThumbnail(String filePath) {
    return safeCall(
      () async => await remoteDataSource.uploadChannelThumbnail(filePath),
    );
  }

  @override
  Future<Either<Failure, PaginatedOwnerVideosEntity>> getOwnerVideos({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getOwnerVideos(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<OwnerPlaylistEntity>>> getOwnerPlaylists() {
    return safeCall(() async {
      final models = await remoteDataSource.getOwnerPlaylists();
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, PaginatedSubscribersEntity>> getSubscribers({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.getSubscribers(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return model.toEntity();
    });
  }
}
