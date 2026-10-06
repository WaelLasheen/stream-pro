import 'package:stream_pro/feature/Likes/domain/entities/liked_video_item_entity.dart';

class LikedVideosFeedEntity {
  final List<LikedVideoItemEntity> items;
  final int videoCount;

  const LikedVideosFeedEntity({
    required this.items,
    required this.videoCount,
  });
}