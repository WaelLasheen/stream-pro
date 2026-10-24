import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/playlist/data/datasources/playlist_remote_datasource.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final PlaylistRemoteDataSource remoteDataSource;

  PlaylistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<VideoPlaylistEntity>>> getPlaylistsForVideo(
    String videoId,
  ) {
    return safeCall(() async {
      final models = await remoteDataSource.getPlaylistsForVideo(videoId);
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, PlaylistDetailsEntity>> getPlaylistDetails(
    String playlistId,
  ) {
    return safeCall(() async {
      final model = await remoteDataSource.getPlaylistDetails(playlistId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, String>> createPlaylist({
    required String title,
    String? description,
    bool isPublic = false,
  }) {
    return safeCall(() async {
      final playlistId = await remoteDataSource.createPlaylist(
        title: title,
        description: description,
        isPublic: isPublic,
      );
      return playlistId;
    });
  }

  @override
  Future<Either<Failure, void>> updatePlaylist(
    String playlistId, {
    String? title,
    String? description,
    bool? isPublic,
  }) {
    return safeCall(() async {
      await remoteDataSource.updatePlaylist(
        playlistId,
        title: title,
        description: description,
        isPublic: isPublic,
      );
    });
  }

  @override
  Future<Either<Failure, void>> deletePlaylist(String playlistId) {
    return safeCall(() => remoteDataSource.deletePlaylist(playlistId));
  }

  @override
  Future<Either<Failure, void>> addVideoToPlaylist(
    String playlistId,
    String videoId,
  ) {
    return safeCall(
      () => remoteDataSource.addVideoToPlaylist(playlistId, videoId),
    );
  }

  @override
  Future<Either<Failure, void>> removeVideoFromPlaylist(
    String playlistId,
    String videoId,
  ) {
    return safeCall(
      () => remoteDataSource.removeVideoFromPlaylist(playlistId, videoId),
    );
  }

  @override
  Future<Either<Failure, void>> reorderPlaylistVideos(
    String playlistId,
    List<String> videoIds,
  ) {
    return safeCall(
      () => remoteDataSource.reorderPlaylistVideos(playlistId, videoIds),
    );
  }
}
