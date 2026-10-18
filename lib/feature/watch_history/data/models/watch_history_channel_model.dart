import 'package:stream_pro/feature/watch_history/domain/entities/watch_history_channel_entity.dart';

class WatchHistoryChannelModel {
  final String id;
  final String title;
  final String? channelImageUrl;

  const WatchHistoryChannelModel({
    required this.id,
    required this.title,
    this.channelImageUrl,
  });

  factory WatchHistoryChannelModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryChannelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String?,
    );
  }

  WatchHistoryChannelEntity toEntity() {
    return WatchHistoryChannelEntity(
      id: id,
      title: title,
      channelImageUrl: channelImageUrl,
    );
  }
}