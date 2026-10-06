import 'package:stream_pro/feature/channel/data/models/channel_video_model.dart';
import '../../domain/entities/channel_home_entity.dart';
import 'channel_playlist_model.dart';

class ChannelHomeModel {
  final List<ChannelVideoModel> videos;
  final List<ChannelPlaylistModel> playlists;

  const ChannelHomeModel({required this.videos, required this.playlists});

  factory ChannelHomeModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> videosJson = json['videos'] as List<dynamic>? ?? [];
    final List<dynamic> playlistsJson =
        json['playlists'] as List<dynamic>? ?? [];

    return ChannelHomeModel(
      videos: videosJson
          .map((e) => ChannelVideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlists: playlistsJson
          .map((e) => ChannelPlaylistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ChannelHomeEntity toEntity() {
    return ChannelHomeEntity(
      videos: videos.map((e) => e.toEntity()).toList(),
      playlists: playlists.map((e) => e.toEntity()).toList(),
    );
  }
}
