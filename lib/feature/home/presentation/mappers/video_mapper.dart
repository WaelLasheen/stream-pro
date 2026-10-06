import 'package:stream_pro/core/shared/widgets/video_card/video_card.dart';
import 'package:stream_pro/feature/home/domain/entities/video_entity.dart';

extension VideoMapper on VideoEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      duration: duration,
      views: views,
      channel: ChannelData(
        id: channel.id,
        name: channel.title,
        avatarUrl: channel.channelImageUrl,
      ),
    );
  }
}
