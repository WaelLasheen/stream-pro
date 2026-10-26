import 'package:stream_pro/feature/watch_later/data/models/watch_later_video_model.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_item_entity.dart';

class WatchLaterItemModel {
  final String id;
  final DateTime? createdAt;
  final WatchLaterVideoModel video;

  const WatchLaterItemModel({
    required this.id,
    required this.createdAt,
    required this.video,
  });

  factory WatchLaterItemModel.fromJson(Map<String, dynamic> json) {
    return WatchLaterItemModel(
      id: json['id'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      video: WatchLaterVideoModel.fromJson(
        json['video'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  WatchLaterItemEntity toEntity() {
    return WatchLaterItemEntity(
      id: id,
      createdAt: createdAt,
      video: video.toEntity(),
    );
  }
}
