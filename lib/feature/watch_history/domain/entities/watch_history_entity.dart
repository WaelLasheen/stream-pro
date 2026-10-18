import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/watch_history/domain/entities/watch_history_item_entity.dart';

class WatchHistoryEntity extends Equatable {
  final String label;
  final List<WatchHistoryItemEntity> items;

  const WatchHistoryEntity({required this.label, required this.items});

  WatchHistoryEntity copyWith({
    String? label,
    List<WatchHistoryItemEntity>? items,
  }) {
    return WatchHistoryEntity(
      label: label ?? this.label,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [label, items];
}
