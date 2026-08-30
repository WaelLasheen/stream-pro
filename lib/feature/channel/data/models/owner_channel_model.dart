import '../../domain/entities/owner_channel_entity.dart';

class OwnerChannelModel {
  final String id;
  final String title;
  final String description;
  final String channelImageUrl;
  final String thumbnailUrl;

  const OwnerChannelModel({
    required this.id,
    required this.title,
    required this.description,
    required this.channelImageUrl,
    required this.thumbnailUrl,
  });

  factory OwnerChannelModel.fromJson(Map<String, dynamic> json) {
    return OwnerChannelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      channelImageUrl: json['channelImageUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
    );
  }

  OwnerChannelEntity toEntity() {
    return OwnerChannelEntity(
      id: id,
      title: title,
      description: description,
      channelImageUrl: channelImageUrl,
      thumbnailUrl: thumbnailUrl,
    );
  }
}