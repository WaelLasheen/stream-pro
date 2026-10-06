import '../../domain/entities/watch_history_group_entity.dart';

class WatchHistoryVideoInfoModel {
  final String id;
  final String title;
  final String? thumbnailUrl;
  final int durationSeconds;

  const WatchHistoryVideoInfoModel({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    required this.durationSeconds,
  });

  factory WatchHistoryVideoInfoModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryVideoInfoModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      durationSeconds: json['durationSeconds'] as int? ?? 0,
    );
  }

  WatchHistoryVideoInfoEntity toEntity() {
    return WatchHistoryVideoInfoEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      durationSeconds: durationSeconds,
    );
  }
}

class WatchHistoryChannelInfoModel {
  final String id;
  final String title;
  final String? channelImageUrl;

  const WatchHistoryChannelInfoModel({
    required this.id,
    required this.title,
    this.channelImageUrl,
  });

  factory WatchHistoryChannelInfoModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryChannelInfoModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String?,
    );
  }

  WatchHistoryChannelInfoEntity toEntity() {
    return WatchHistoryChannelInfoEntity(
      id: id,
      title: title,
      channelImageUrl: channelImageUrl,
    );
  }
}

class WatchHistoryItemModel {
  final String id;
  final WatchHistoryVideoInfoModel video;
  final int watchedSeconds;
  final int videoDuration;
  final double completionRate;
  final String lastWatchedAt;
  final WatchHistoryChannelInfoModel channel;

  const WatchHistoryItemModel({
    required this.id,
    required this.video,
    required this.watchedSeconds,
    required this.videoDuration,
    required this.completionRate,
    required this.lastWatchedAt,
    required this.channel,
  });

  factory WatchHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryItemModel(
      id: json['id'] as String? ?? '',
      video: WatchHistoryVideoInfoModel.fromJson(
        json['video'] as Map<String, dynamic>? ?? {},
      ),
      watchedSeconds: json['watchedSeconds'] as int? ?? 0,
      videoDuration: json['videoDuration'] as int? ?? 0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
      lastWatchedAt: json['lastWatchedAt'] as String? ?? '',
      channel: WatchHistoryChannelInfoModel.fromJson(
        json['channel'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  WatchHistoryItemEntity toEntity() {
    return WatchHistoryItemEntity(
      id: id,
      video: video.toEntity(),
      watchedSeconds: watchedSeconds,
      videoDuration: videoDuration,
      completionRate: completionRate,
      lastWatchedAt: lastWatchedAt,
      channel: channel.toEntity(),
    );
  }
}

class WatchHistoryGroupModel {
  final String label;
  final List<WatchHistoryItemModel> items;

  const WatchHistoryGroupModel({
    required this.label,
    required this.items,
  });

  factory WatchHistoryGroupModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return WatchHistoryGroupModel(
      label: json['label'] as String? ?? '',
      items: rawItems
          .map((item) => WatchHistoryItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  WatchHistoryGroupEntity toEntity() {
    return WatchHistoryGroupEntity(
      label: label,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}