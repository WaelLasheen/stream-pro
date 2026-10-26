import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

sealed class VideoPlayerState extends Equatable {
  final VideoPlayerController? videoController;
  final ChewieController? chewieController;

  const VideoPlayerState({this.videoController, this.chewieController});

  @override
  List<Object?> get props => [videoController, chewieController];
}

class VideoPlayerInitial extends VideoPlayerState {
  const VideoPlayerInitial();
}

class VideoPlayerLoading extends VideoPlayerState {
  const VideoPlayerLoading();
}

class VideoPlayerLoaded extends VideoPlayerState {
  const VideoPlayerLoaded({
    required VideoPlayerController videoController,
    required ChewieController chewieController,
  }) : super(
         videoController: videoController,
         chewieController: chewieController,
       ); 

  @override
  List<Object?> get props => [videoController, chewieController];
}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
