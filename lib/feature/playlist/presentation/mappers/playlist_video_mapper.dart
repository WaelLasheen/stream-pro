import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';

extension PlaylistVideoMapper on PlaylistVideoEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: videoId,
      title: title,
      thumbnailUrl: thumbnailUrl ?? '',
      duration: durationSeconds,
      views: views,
      publishedTime: createdAt,
      channel: ChannelData(
        id: channelId,
        name: channelTitle,
        avatarUrl: channelImageUrl ?? '',
      ),
    );
  }
}
