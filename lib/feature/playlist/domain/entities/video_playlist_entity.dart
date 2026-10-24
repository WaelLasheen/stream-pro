import 'package:equatable/equatable.dart';

class VideoPlaylistEntity extends Equatable {
  final String playlistId;
  final String title;
  final bool isPublic;
  final bool hasVideo;

  const VideoPlaylistEntity({
    required this.playlistId,
    required this.title,
    required this.isPublic,
    required this.hasVideo,
  });

  VideoPlaylistEntity copyWith({bool? hasVideo}) {
    return VideoPlaylistEntity(
      playlistId: playlistId,
      title: title,
      isPublic: isPublic,
      hasVideo: hasVideo ?? this.hasVideo,
    );
  }

  @override
  List<Object?> get props => [playlistId, title, isPublic, hasVideo];
}
