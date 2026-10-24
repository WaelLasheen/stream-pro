import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/playlist/data/datasources/playlist_remote_datasource.dart';
import 'package:stream_pro/feature/playlist/data/models/playlist_details_model.dart';
import 'package:stream_pro/feature/playlist/data/models/video_playlist_model.dart';

class PlaylistRemoteDataSourceImpl implements PlaylistRemoteDataSource {
  final ApiService apiService;

  PlaylistRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<VideoPlaylistModel>> getPlaylistsForVideo(String videoId) async {
    final response = await apiService.get(
      ApiConstants.playlistsForVideo(videoId),
    );
    final data = response.data as List<dynamic>;
    return data.map((e) => VideoPlaylistModel.fromJson(e)).toList();
  }

  @override
  Future<PlaylistDetailsModel> getPlaylistDetails(String playlistId) async {
    final response = await apiService.get(
      ApiConstants.playlistById(playlistId),
    );
    final data = response.data;

    return PlaylistDetailsModel.fromJson(data);
  }

  @override
  Future<String> createPlaylist({
    required String title,
    String? description,
    bool isPublic = false,
  }) async {
    final response = await apiService.post(
      ApiConstants.playlists,
      data: {
        'title': title,
        if (description != null && description.isNotEmpty)
          'description': description,
        'isPublic': isPublic,
      },
    );

    return response.data['playlistId'] as String;
  }

  @override
  Future<void> updatePlaylist(
    String playlistId, {
    String? title,
    String? description,
    bool? isPublic,
  }) async {
    await apiService.patch(
      ApiConstants.playlistById(playlistId),
      data: {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (isPublic != null) 'isPublic': isPublic,
      },
    );
  }

  @override
  Future<void> deletePlaylist(String playlistId) async {
    await apiService.delete(ApiConstants.playlistById(playlistId));
  }

  @override
  Future<void> addVideoToPlaylist(String playlistId, String videoId) async {
    await apiService.post(ApiConstants.playlistVideo(playlistId, videoId));
  }

  @override
  Future<void> removeVideoFromPlaylist(
    String playlistId,
    String videoId,
  ) async {
    await apiService.delete(ApiConstants.playlistVideo(playlistId, videoId));
  }

  @override
  Future<void> reorderPlaylistVideos(
    String playlistId,
    List<String> videoIds,
  ) async {
    await apiService.patch(
      ApiConstants.reorderPlaylistVideos(playlistId),
      data: {'videoIds': videoIds},
    );
  }
}
