import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';

class PlaylistDetailsEntity extends Equatable {
  final String playlistId;
  final String title;
  final String? description;
  final bool isPublic;
  final int videoCount;
  final List<PlaylistVideoEntity> videos;

  const PlaylistDetailsEntity({
    required this.playlistId,
    required this.title,
    this.description,
    required this.isPublic,
    required this.videoCount,
    required this.videos,
  });

  PlaylistDetailsEntity copyWith({
    String? title,
    String? description,
    bool? isPublic,
    int? videoCount,
    List<PlaylistVideoEntity>? videos,
  }) {
    return PlaylistDetailsEntity(
      playlistId: playlistId,
      title: title ?? this.title,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      videoCount: videoCount ?? this.videoCount,
      videos: videos ?? this.videos,
    );
  }

  @override
  List<Object?> get props => [
    playlistId,
    title,
    description,
    isPublic,
    videoCount,
    videos,
  ];
}
