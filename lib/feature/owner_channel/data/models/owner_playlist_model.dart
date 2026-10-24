import '../../domain/entities/owner_playlist_entity.dart';

class OwnerPlaylistModel {
  final String id;
  final String title;
  final String? description;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int videoCount;
  final List<String> thumbnails;

  const OwnerPlaylistModel({
    required this.id,
    required this.title,
    this.description,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.videoCount = 0,
    this.thumbnails = const [],
  });

  factory OwnerPlaylistModel.fromJson(Map<String, dynamic> json) {
    return OwnerPlaylistModel(
      id: json['id'] as String,
      title: json['title'] ?? '',
      description: json['description'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      videoCount: json['videoCount'] ?? 0,
      thumbnails: _parseThumbnails(json['videos']),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is! String || value.isEmpty) return DateTime.now();
    return DateTime.tryParse(value) ?? DateTime.now();
  }

  static List<String> _parseThumbnails(dynamic videos) {
    if (videos is! List) return const [];

    final thumbnails = <String>[];
    for (final video in videos) {
      if (video is! Map) continue;
      final url = video['thumbnailUrl'];
      if (url is String && url.isNotEmpty) thumbnails.add(url);
    }
    return thumbnails;
  }

  OwnerPlaylistEntity toEntity() {
    return OwnerPlaylistEntity(
      id: id,
      title: title,
      description: description,
      isPublic: isPublic,
      createdAt: createdAt,
      updatedAt: updatedAt,
      videoCount: videoCount,
      thumbnails: thumbnails,
    );
  }
}
