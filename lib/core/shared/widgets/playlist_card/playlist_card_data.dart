import 'package:equatable/equatable.dart';

enum PlaylistCardVariant { vertical, horizontal }

class PlaylistCardData extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isPublic;
  final int videosCount;
  final List<String> thumbnails;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PlaylistCardData({
    required this.id,
    required this.title,
    this.description,
    required this.isPublic,
    required this.videosCount,
    required this.thumbnails,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isPublic,
    videosCount,
    thumbnails,
    createdAt,
    updatedAt,
  ];
}
