import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';

abstract class PlaylistRepository {
  Future<Either<Failure, List<VideoPlaylistEntity>>> getPlaylistsForVideo(
    String videoId,
  );

  Future<Either<Failure, PlaylistDetailsEntity>> getPlaylistDetails(
    String playlistId,
  );

  Future<Either<Failure, String>> createPlaylist({
    required String title,
    String? description,
    bool isPublic = false,
  });

  Future<Either<Failure, void>> updatePlaylist(
    String playlistId, {
    String? title,
    String? description,
    bool? isPublic,
  });

  Future<Either<Failure, void>> deletePlaylist(String playlistId);

  Future<Either<Failure, void>> addVideoToPlaylist(
    String playlistId,
    String videoId,
  );

  Future<Either<Failure, void>> removeVideoFromPlaylist(
    String playlistId,
    String videoId,
  );

  Future<Either<Failure, void>> reorderPlaylistVideos(
    String playlistId,
    List<String> videoIds,
  );
}
