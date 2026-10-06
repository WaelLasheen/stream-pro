import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_video_entity.dart';

extension OwnerVideoMapper on OwnerVideoEntity {
  VideoCardData toVideoCardData() {
    return VideoCardData(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      duration: durationSeconds,
      views: views,
      description: description,
      publishedTime: createdAt,
    );
  }
}
