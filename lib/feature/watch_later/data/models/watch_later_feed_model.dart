import 'package:stream_pro/feature/watch_later/data/models/watch_later_item_model.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_feed_entity.dart';

class WatchLaterFeedModel {
  final List<WatchLaterItemModel> items;
  final int videoCount;

  const WatchLaterFeedModel({required this.items, required this.videoCount});

  factory WatchLaterFeedModel.fromJson(Map<String, dynamic> json) {
    return WatchLaterFeedModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) =>
                    WatchLaterItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      videoCount: (json['videoCount'] as num?)?.toInt() ?? 0,
    );
  }

  WatchLaterFeedEntity toEntity() {
    return WatchLaterFeedEntity(
      items: items.map((item) => item.toEntity()).toList(),
      videoCount: videoCount,
    );
  }
}
