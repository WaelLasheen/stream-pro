import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import '../../domain/entities/watch_history_item_entity.dart';

extension WatchHistoryItemMapper on WatchHistoryItemEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: video.id,
      title: video.title,
      thumbnailUrl: video.thumbnailUrl ?? '',
      duration: video.durationSeconds,
      views: 0,
      channel: ChannelData(
        id: channel.id,
        name: channel.title,
        avatarUrl: channel.channelImageUrl ?? '',
      ),
      completionRate: completionRate,
      watchedSeconds: watchedSeconds,
    );
  }
}
