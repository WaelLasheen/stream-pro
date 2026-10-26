import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_channel_entity.dart';

class WatchLaterChannelModel {
  final String id;
  final String title;
  final String channelImageUrl;

  const WatchLaterChannelModel({
    required this.id,
    required this.title,
    required this.channelImageUrl,
  });

  factory WatchLaterChannelModel.fromJson(Map<String, dynamic> json) {
    return WatchLaterChannelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
    );
  }

  WatchLaterChannelEntity toEntity() {
    return WatchLaterChannelEntity(
      id: id,
      title: title,
      channelImageUrl: channelImageUrl,
    );
  }
}
