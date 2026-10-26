import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_video_entity.dart';

class WatchLaterItemEntity extends Equatable {
  final String id;
  final DateTime? createdAt;
  final WatchLaterVideoEntity video;

  const WatchLaterItemEntity({
    required this.id,
    required this.createdAt,
    required this.video,
  });

  @override
  List<Object?> get props => [id, createdAt, video];
}
