import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';

sealed class VideoPlaylistsState extends Equatable {
  final List<VideoPlaylistEntity> playlists;
  final Set<String> pendingPlaylistIds;

  const VideoPlaylistsState({
    this.playlists = const [],
    this.pendingPlaylistIds = const {},
  });

  @override
  List<Object?> get props => [playlists, pendingPlaylistIds];
}

final class VideoPlaylistsInitial extends VideoPlaylistsState {
  const VideoPlaylistsInitial();
}

final class VideoPlaylistsLoading extends VideoPlaylistsState {
  const VideoPlaylistsLoading();
}

final class VideoPlaylistsLoaded extends VideoPlaylistsState {
  const VideoPlaylistsLoaded({super.playlists, super.pendingPlaylistIds});
}

final class VideoPlaylistsFailure extends VideoPlaylistsState {
  final String errorMessage;

  const VideoPlaylistsFailure({
    required this.errorMessage,
    super.playlists,
    super.pendingPlaylistIds,
  });

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
