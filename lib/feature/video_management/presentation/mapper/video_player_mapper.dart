import 'package:stream_pro/core/shared/widgets/video_player/video_player_data.dart';
import 'package:stream_pro/feature/video_management/domain/entities/managed_video_entity.dart';

extension VideoPlayerMapper on ManagedVideoEntity {
  VideoPlayerData toVideoPlayerData() {
    return VideoPlayerData(
      videoUrl: hlsUrl ?? '',
      posterUrl: thumbnailUrl,
      title: title,
      autoPlay: false,
      looping: false,
    );
  }
}
