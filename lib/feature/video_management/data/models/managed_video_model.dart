import '../../domain/entities/managed_video_entity.dart';

class ManagedVideoModel {
  final String id;
  final String title;
  final String description;
  final String? hlsUrl;
  final String? thumbnailUrl;
  final int durationSeconds;
  final int views;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final bool isPublished;
  final DateTime? publishTime;
  final List<String> tags;
  final String? categoryId;

  const ManagedVideoModel({
    required this.id,
    required this.title,
    required this.description,
    this.hlsUrl,
    this.thumbnailUrl,
    required this.durationSeconds,
    required this.views,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.isPublished,
    this.publishTime,
    required this.tags,
    this.categoryId,
  });

  factory ManagedVideoModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final rawPublishTime = data['publishTime'] as String?;

    return ManagedVideoModel(
      id: data['id'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      hlsUrl: data['hlsUrl'] as String?,
      thumbnailUrl: data['thumbnailUrl'] as String?,
      durationSeconds: (data['durationSeconds'] as num?)?.toInt() ?? 0,
      views: (data['views'] as num?)?.toInt() ?? 0,
      likesCount: (data['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (data['commentsCount'] as num?)?.toInt() ?? 0,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'] as String)
          : DateTime.now(),
      isPublished: data['isPublished'] as bool? ?? false,
      publishTime: rawPublishTime != null
          ? DateTime.tryParse(rawPublishTime)?.toLocal()
          : null,
      tags:
          (data['tags'] as List<dynamic>?)?.whereType<String>().toList() ??
          const [],
      categoryId: data['categoryId'] as String?,
    );
  }

  ManagedVideoEntity toEntity() {
    return ManagedVideoEntity(
      id: id,
      title: title,
      description: description,
      hlsUrl: hlsUrl,
      thumbnailUrl: thumbnailUrl,
      durationSeconds: durationSeconds,
      views: views,
      likesCount: likesCount,
      commentsCount: commentsCount,
      createdAt: createdAt,
      isPublished: isPublished,
      publishTime: publishTime,
      tags: tags,
      categoryId: categoryId,
    );
  }
}
