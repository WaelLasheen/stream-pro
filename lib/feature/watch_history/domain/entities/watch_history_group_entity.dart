import 'package:equatable/equatable.dart';

class WatchHistoryVideoInfoEntity extends Equatable {
  final String id;
  final String title;
  final String? thumbnailUrl;
  final int durationSeconds;

  const WatchHistoryVideoInfoEntity({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    required this.durationSeconds,
  });

  @override
  List<Object?> get props => [id, title, thumbnailUrl, durationSeconds];
}

class WatchHistoryChannelInfoEntity extends Equatable {
  final String id;
  final String title;
  final String? channelImageUrl;

  const WatchHistoryChannelInfoEntity({
    required this.id,
    required this.title,
    this.channelImageUrl,
  });

  @override
  List<Object?> get props => [id, title, channelImageUrl];
}

class WatchHistoryItemEntity extends Equatable {
  final String id;
  final WatchHistoryVideoInfoEntity video;
  final int watchedSeconds;
  final int videoDuration;
  final double completionRate;
  final String lastWatchedAt;
  final WatchHistoryChannelInfoEntity channel;

  const WatchHistoryItemEntity({
    required this.id,
    required this.video,
    required this.watchedSeconds,
    required this.videoDuration,
    required this.completionRate,
    required this.lastWatchedAt,
    required this.channel,
  });

  WatchHistoryItemEntity copyWith({
    String? id,
    WatchHistoryVideoInfoEntity? video,
    int? watchedSeconds,
    int? videoDuration,
    double? completionRate,
    String? lastWatchedAt,
    WatchHistoryChannelInfoEntity? channel,
  }) {
    return WatchHistoryItemEntity(
      id: id ?? this.id,
      video: video ?? this.video,
      watchedSeconds: watchedSeconds ?? this.watchedSeconds,
      videoDuration: videoDuration ?? this.videoDuration,
      completionRate: completionRate ?? this.completionRate,
      lastWatchedAt: lastWatchedAt ?? this.lastWatchedAt,
      channel: channel ?? this.channel,
    );
  }

  @override
  List<Object?> get props => [
    id,
    video,
    watchedSeconds,
    videoDuration,
    completionRate,
    lastWatchedAt,
    channel,
  ];
}

class WatchHistoryGroupEntity extends Equatable {
  final String label;
  final List<WatchHistoryItemEntity> items;

  const WatchHistoryGroupEntity({required this.label, required this.items});

  WatchHistoryGroupEntity copyWith({
    String? label,
    List<WatchHistoryItemEntity>? items,
  }) {
    return WatchHistoryGroupEntity(
      label: label ?? this.label,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [label, items];
}
