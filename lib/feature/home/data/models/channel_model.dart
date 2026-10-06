import '../../domain/entities/channel_entity.dart';

class ChannelModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelImageUrl;

  const ChannelModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelImageUrl,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
    );
  }

  ChannelEntity toEntity() {
    return ChannelEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      channelImageUrl: channelImageUrl,
    );
  }
}
