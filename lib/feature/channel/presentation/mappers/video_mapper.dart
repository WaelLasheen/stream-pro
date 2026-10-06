import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_video_entity.dart';

extension VideoMapper on ChannelVideoEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      duration: duration,
      views: views,
      publishedTime: createdAt,
    );
  }
}
