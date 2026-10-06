import 'package:stream_pro/feature/Likes/domain/entities/channel_entity.dart';

class ChannelModel {
  final String id;
  final String title;
  final String channelImageUrl;

  const ChannelModel({
    required this.id,
    required this.title,
    required this.channelImageUrl,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
    );
  }

  ChannelEntity toEntity() {
    return ChannelEntity(
      id: id,
      title: title,
      channelImageUrl: channelImageUrl,
    );
  }
}
