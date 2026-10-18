import 'package:stream_pro/feature/watch_history/data/models/watch_history_item_model.dart';
import '../../domain/entities/watch_history_entity.dart';

class WatchHistoryModel {
  final String label;
  final List<WatchHistoryItemModel> items;

  const WatchHistoryModel({required this.label, required this.items});

  factory WatchHistoryModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return WatchHistoryModel(
      label: json['label'] as String? ?? '',
      items: rawItems
          .map(
            (item) =>
                WatchHistoryItemModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  WatchHistoryEntity toEntity() {
    return WatchHistoryEntity(
      label: label,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}
