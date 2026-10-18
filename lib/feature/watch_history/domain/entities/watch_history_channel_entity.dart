import 'package:equatable/equatable.dart';

class WatchHistoryChannelEntity extends Equatable {
  final String id;
  final String title;
  final String? channelImageUrl;

  const WatchHistoryChannelEntity({
    required this.id,
    required this.title,
    this.channelImageUrl,
  });

  @override
  List<Object?> get props => [id, title, channelImageUrl];
}
