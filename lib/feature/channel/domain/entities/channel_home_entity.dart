import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_video_entity.dart';
import 'channel_playlist_entity.dart';

class ChannelHomeEntity extends Equatable {
  final List<ChannelVideoEntity> videos;
  final List<ChannelPlaylistEntity> playlists;

  const ChannelHomeEntity({
    required this.videos,
    required this.playlists,
  });

  @override
  List<Object?> get props => [videos, playlists];
}