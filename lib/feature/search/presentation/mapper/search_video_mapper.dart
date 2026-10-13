import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/feature/search/domain/entities/search_video_entity.dart';

extension SearchVideoMapper on SearchVideoEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: videoId,
      title: title,
      thumbnailUrl: thumbnailUrl,
      duration: durationSeconds,
      views: views,
      publishedTime: updatedAt,
      channel: ChannelData(
        id: channelId,
        name: channelName,
        avatarUrl: channelProfileImageUrl,
      ),
    );
  }
}
