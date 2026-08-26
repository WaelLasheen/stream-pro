import '../../domain/entities/channel_entity.dart';

class ChannelModel {
  final String id;
  final String title;
  final String thumbnailUrl;

  const ChannelModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
    );
  }

  ChannelEntity toEntity() {
    return ChannelEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
    );
  }
}