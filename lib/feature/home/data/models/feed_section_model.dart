import '../../domain/entities/feed_section_entity.dart';
import 'video_model.dart';

class FeedSectionModel {
  final String key;
  final String title;
  final String type;
  final List<VideoModel> videos;

  const FeedSectionModel({
    required this.key,
    required this.title,
    required this.type,
    required this.videos,
  });

  factory FeedSectionModel.fromJson(Map<String, dynamic> json) {
    return FeedSectionModel(
      key: json['key'] as String? ?? '',
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
      videos: (json['videos'] as List<dynamic>?)
              ?.map((v) => VideoModel.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  FeedSectionEntity toEntity() {
    return FeedSectionEntity(
      key: key,
      title: title,
      type: type,
      videos: videos.map((v) => v.toEntity()).toList(),
    );
  }
}