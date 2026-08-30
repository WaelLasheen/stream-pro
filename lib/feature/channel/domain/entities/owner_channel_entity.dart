import 'package:equatable/equatable.dart';

class OwnerChannelEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String channelImageUrl;
  final String thumbnailUrl;

  const OwnerChannelEntity({
    required this.id,
    required this.title,
    this.description,
    required this.channelImageUrl,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, title, description, channelImageUrl, thumbnailUrl];
}