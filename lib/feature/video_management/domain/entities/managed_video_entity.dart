import 'package:equatable/equatable.dart';

class ManagedVideoEntity extends Equatable {
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

  const ManagedVideoEntity({
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

  ManagedVideoEntity copyWith({
    String? title,
    String? description,
    String? thumbnailUrl,
    bool? isPublished,
    List<String>? tags,
    String? categoryId,
    DateTime? publishTime,
  }) {
    return ManagedVideoEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      hlsUrl: hlsUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      durationSeconds: durationSeconds,
      views: views,
      likesCount: likesCount,
      commentsCount: commentsCount,
      createdAt: createdAt,
      isPublished: isPublished ?? this.isPublished,
      publishTime: publishTime ?? this.publishTime,
      tags: tags ?? this.tags,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    hlsUrl,
    thumbnailUrl,
    durationSeconds,
    views,
    likesCount,
    commentsCount,
    createdAt,
    isPublished,
    publishTime,
    tags,
    categoryId,
  ];
}
