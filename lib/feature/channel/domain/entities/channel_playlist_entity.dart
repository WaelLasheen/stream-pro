import 'package:equatable/equatable.dart';

class ChannelPlaylistEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final int videosCount;

  const ChannelPlaylistEntity({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnailUrl,
    required this.videosCount,
  });

  @override
  List<Object?> get props => [id, title, description, thumbnailUrl, videosCount];
}