import '../../domain/entities/liked_videos_feed_entity.dart';
import 'liked_video_item_model.dart';

class LikedVideosResponseModel {
  final List<LikedVideoItemModel> items;
  final int videoCount;

  const LikedVideosResponseModel({
    required this.items,
    required this.videoCount,
  });

  factory LikedVideosResponseModel.fromJson(Map<String, dynamic> json) {
    return LikedVideosResponseModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => LikedVideoItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      videoCount: json['videoCount'] as int? ?? 0,
    );
  }

  LikedVideosFeedEntity toEntity() {
    return LikedVideosFeedEntity(
      items: items.map((e) => e.toEntity()).toList(),
      videoCount: videoCount,
    );
  }
}