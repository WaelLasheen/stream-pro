import 'package:equatable/equatable.dart';
import 'video_entity.dart';

class FeedSectionEntity extends Equatable {
  final String key;
  final String title;
  final String type;
  final List<VideoEntity> videos;

  const FeedSectionEntity({
    required this.key,
    required this.title,
    required this.type,
    required this.videos,
  });

  @override
  List<Object?> get props => [key, title, type, videos];
}