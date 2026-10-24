import 'package:stream_pro/feature/playlist/data/models/playlist_details_model.dart';
import 'package:stream_pro/feature/playlist/data/models/video_playlist_model.dart';

abstract class PlaylistRemoteDataSource {
  Future<List<VideoPlaylistModel>> getPlaylistsForVideo(String videoId);

  Future<PlaylistDetailsModel> getPlaylistDetails(String playlistId);

  Future<String> createPlaylist({
    required String title,
    String? description,
    bool isPublic = false,
  });

  Future<void> updatePlaylist(
    String playlistId, {
    String? title,
    String? description,
    bool? isPublic,
  });

  Future<void> deletePlaylist(String playlistId);

  Future<void> addVideoToPlaylist(String playlistId, String videoId);

  Future<void> removeVideoFromPlaylist(String playlistId, String videoId);

  Future<void> reorderPlaylistVideos(String playlistId, List<String> videoIds);
}
