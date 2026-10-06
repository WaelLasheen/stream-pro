import 'package:equatable/equatable.dart';

/// A playlist as returned by `/api/v1/playlists` (the owner's own playlists).
class OwnerPlaylistEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int videoCount;
  final String? thumbnailUrl;
  final String? firstVideoId;

  const OwnerPlaylistEntity({
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

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isPublic,
    createdAt,
    updatedAt,
    videoCount,
    thumbnailUrl,
    firstVideoId,
  ];
}
