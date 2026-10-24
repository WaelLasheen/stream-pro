import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/create_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/delete_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/get_playlist_details_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/get_playlists_for_video_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/reorder_playlist_videos_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/toggle_video_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/update_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/create_playlist_cubit/create_playlist_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_cubit.dart';

const kFailure = ServerFailure('request failed');

/// Builds a playlist video with the required server fields filled in.
PlaylistVideoEntity testVideo(
  String videoId, {
  String? title,
  String? thumbnailUrl,
  String? channelImageUrl,
  int views = 0,
}) {
  return PlaylistVideoEntity(
    videoId: videoId,
    title: title ?? 'Video $videoId',
    thumbnailUrl: thumbnailUrl,
    durationSeconds: 60,
    views: views,
    createdAt: DateTime(2026, 1, 1),
    channelId: 'channel-1',
    channelTitle: 'Channel',
    channelImageUrl: channelImageUrl,
  );
}

class FakePlaylistRepository implements PlaylistRepository {
  List<VideoPlaylistEntity> playlistsForVideo = [];
  PlaylistDetailsEntity? playlist;
  String createdPlaylistId = 'new';

  bool failCreate = false;
  bool failAdd = false;
  bool failRemove = false;
  bool failReorder = false;
  bool failUpdate = false;

  final List<List<String>> reorderCalls = [];
  final List<String> addedVideos = [];
  final List<String> removedVideos = [];
  final List<String> createdTitles = [];

  @override
  Future<Either<Failure, List<VideoPlaylistEntity>>> getPlaylistsForVideo(
    String videoId,
  ) async {
    return Right(playlistsForVideo);
  }

  @override
  Future<Either<Failure, PlaylistDetailsEntity>> getPlaylistDetails(
    String playlistId,
  ) async {
    return Right(
      playlist ??
          PlaylistDetailsEntity(
            playlistId: playlistId,
            title: 'My Playlist',
            isPublic: false,
            videoCount: 0,
            videos: const [],
          ),
    );
  }

  @override
  Future<Either<Failure, String>> createPlaylist({
    required String title,
    String? description,
    bool isPublic = false,
  }) async {
    if (failCreate) return const Left(kFailure);
    createdTitles.add(title);
    return Right(createdPlaylistId);
  }

  @override
  Future<Either<Failure, void>> updatePlaylist(
    String playlistId, {
    String? title,
    String? description,
    bool? isPublic,
  }) async {
    if (failUpdate) return const Left(kFailure);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deletePlaylist(String playlistId) async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> addVideoToPlaylist(
    String playlistId,
    String videoId,
  ) async {
    if (failAdd) return const Left(kFailure);
    addedVideos.add('$playlistId/$videoId');
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeVideoFromPlaylist(
    String playlistId,
    String videoId,
  ) async {
    if (failRemove) return const Left(kFailure);
    removedVideos.add('$playlistId/$videoId');
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> reorderPlaylistVideos(
    String playlistId,
    List<String> videoIds,
  ) async {
    if (failReorder) return const Left(kFailure);
    reorderCalls.add(videoIds);
    return const Right(null);
  }
}

VideoPlaylistsCubit buildVideoPlaylistsCubit(FakePlaylistRepository repo) {
  return VideoPlaylistsCubit(
    getPlaylistsForVideoUseCase: GetPlaylistsForVideoUseCase(repo),
    toggleVideoPlaylistUseCase: ToggleVideoPlaylistUseCase(repo),
  );
}

PlaylistDetailsCubit buildPlaylistDetailsCubit(FakePlaylistRepository repo) {
  return PlaylistDetailsCubit(
    getPlaylistDetailsUseCase: GetPlaylistDetailsUseCase(repo),
    updatePlaylistUseCase: UpdatePlaylistUseCase(repo),
    deletePlaylistUseCase: DeletePlaylistUseCase(repo),
    toggleVideoPlaylistUseCase: ToggleVideoPlaylistUseCase(repo),
    reorderPlaylistVideosUseCase: ReorderPlaylistVideosUseCase(repo),
  );
}

CreatePlaylistCubit buildCreatePlaylistCubit(FakePlaylistRepository repo) {
  return CreatePlaylistCubit(
    createPlaylistUseCase: CreatePlaylistUseCase(repo),
    toggleVideoPlaylistUseCase: ToggleVideoPlaylistUseCase(repo),
  );
}
