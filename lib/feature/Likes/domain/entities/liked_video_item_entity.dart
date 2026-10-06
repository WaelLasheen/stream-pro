import 'package:stream_pro/feature/Likes/domain/entities/video_entity.dart';

class LikedVideoItemEntity {
  final String id;
  final DateTime createdAt;
  final VideoEntity video;

  const LikedVideoItemEntity({
    required this.id,
    required this.createdAt,
    required this.video,
  });
}
