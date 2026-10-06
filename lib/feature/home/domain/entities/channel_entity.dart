import 'package:equatable/equatable.dart';

class ChannelEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelImageUrl;

  const ChannelEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelImageUrl,
  });

  @override
  List<Object?> get props => [id, title, thumbnailUrl,channelImageUrl];
}