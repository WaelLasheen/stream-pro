import 'package:stream_pro/core/shared/widgets/video_player/video_player_data.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';

extension VideoPlayerMapper on VideoEntity {
  VideoPlayerData toVideoPlayerData() {
    return VideoPlayerData(
      videoUrl: hlsUrl,
      posterUrl: thumbnailUrl,
      title: title,
      autoPlay: true,
    );
  }
}
