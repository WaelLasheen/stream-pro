import 'package:equatable/equatable.dart';

class WatchLaterChannelEntity extends Equatable {
  final String id;
  final String title;
  final String channelImageUrl;

  const WatchLaterChannelEntity({
    required this.id,
    required this.title,
    required this.channelImageUrl,
  });

  @override
  List<Object?> get props => [id, title, channelImageUrl];
}
