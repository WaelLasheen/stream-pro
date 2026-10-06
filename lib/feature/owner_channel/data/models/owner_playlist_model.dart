import '../../domain/entities/owner_playlist_entity.dart';

class OwnerPlaylistModel {
  final String id;
  final String title;
  final String? description;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int videoCount;
  final String? thumbnailUrl;
  final String? firstVideoId;

  const OwnerPlaylistModel({
    required this.id,
    required this.title,
    this.description,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    required this.videoCount,
    this.thumbnailUrl,
    this.firstVideoId,
  });

  factory OwnerPlaylistModel.fromJson(Map<String, dynamic> json) {
    return OwnerPlaylistModel(
      id: json['playlistId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      videoCount: (json['videoCount'] as num?)?.toInt() ?? 0,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      firstVideoId: json['firstVideoId'] as String?,
    );
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
      thumbnailUrl: thumbnailUrl,
      firstVideoId: firstVideoId,
    );
  }
}
