import 'package:equatable/equatable.dart';

class OwnerPlaylistEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int videoCount;
  final List<String> thumbnails;

  const OwnerPlaylistEntity({
    required this.id,
    required this.title,
    this.description,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.videoCount = 0,
    this.thumbnails = const [],
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
    thumbnails,
  ];
}
