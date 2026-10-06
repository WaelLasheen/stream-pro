import 'package:equatable/equatable.dart';

class ChannelPlaylistEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final List<String> thumbnails;
  final bool isPublic;
  final int videosCount;

  const ChannelPlaylistEntity({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnails,
    required this.videosCount,
    required this.isPublic,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    thumbnails,
    videosCount,
    isPublic,
  ];
}
