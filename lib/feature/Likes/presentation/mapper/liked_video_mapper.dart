import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/feature/Likes/domain/entities/liked_video_item_entity.dart';

extension LikedVideoMapper on LikedVideoItemEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: video.id,
      title: video.title,
      thumbnailUrl: video.thumbnailUrl,
      duration: video.durationSeconds,
      views: video.views,
      publishedTime: createdAt,
      channel: ChannelData(
        id: video.channel.id,
        name: video.channel.title,
        avatarUrl: video.channel.channelImageUrl,
      ),
    );
  }
}