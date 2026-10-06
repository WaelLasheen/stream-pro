import 'package:equatable/equatable.dart';

class VideoPlayerData extends Equatable {
  final String videoUrl;
  final String? posterUrl;
  final String? title;
  final bool autoPlay;
  final bool looping;

  const VideoPlayerData({
    required this.videoUrl,
    this.posterUrl,
    this.title,
    this.autoPlay = false,
    this.looping = false,
  });

  @override
  List<Object?> get props => [videoUrl, posterUrl, title, autoPlay, looping];
}
