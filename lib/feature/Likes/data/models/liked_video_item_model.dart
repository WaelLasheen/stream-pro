import 'package:stream_pro/feature/Likes/domain/entities/liked_video_item_entity.dart';
import 'video_model.dart';

class LikedVideoItemModel {
  final String id;
  final DateTime createdAt;
  final VideoModel video;

  const LikedVideoItemModel({
    required this.id,
    required this.createdAt,
    required this.video,
  });

  factory LikedVideoItemModel.fromJson(Map<String, dynamic> json) {
    return LikedVideoItemModel(
      id: json['id'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      video: VideoModel.fromJson(json['video'] as Map<String, dynamic>? ?? {}),
    );
  }

  LikedVideoItemEntity toEntity() {
    return LikedVideoItemEntity(
      id: id,
      createdAt: createdAt,
      video: video.toEntity(),
    );
  }
}
