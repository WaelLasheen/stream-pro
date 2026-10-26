import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_item_entity.dart';

class WatchLaterFeedEntity extends Equatable {
  final List<WatchLaterItemEntity> items;
  final int videoCount;

  const WatchLaterFeedEntity({required this.items, required this.videoCount});

  WatchLaterFeedEntity copyWith({
    List<WatchLaterItemEntity>? items,
    int? videoCount,
  }) {
    return WatchLaterFeedEntity(
      items: items ?? this.items,
      videoCount: videoCount ?? this.videoCount,
    );
  }

  @override
  List<Object?> get props => [items, videoCount];
}
