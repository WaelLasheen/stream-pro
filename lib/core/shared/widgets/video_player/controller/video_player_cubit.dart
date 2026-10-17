import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/shared/widgets/video_player/custom_material_controls.dart';
import 'package:video_player/video_player.dart';
import 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(const VideoPlayerInitial());

  Future<void> initializeVideo(String videoUrl, String? posterUrl) async {
    emit(const VideoPlayerLoading());

    try {
      final videoController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );
      await videoController.initialize();

      final aspectRatio = videoController.value.aspectRatio > 0
          ? videoController.value.aspectRatio
          : 16 / 9;

      final chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: false,
        looping: false,
        aspectRatio: aspectRatio,
        playbackSpeeds: const [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0],
        customControls:  const CustomMaterialControls(), 
        placeholder: Container(
          color: Colors.black,
        ), // <-- FIX: No thumbnail here!
        errorBuilder: (context, errorMessage) => _buildErrorWidget(),
      );
      if (isClosed) return;
      emit(
        VideoPlayerLoaded(
          videoController: videoController,
          chewieController: chewieController,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(VideoPlayerError(e.toString()));
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.white70, size: 48),
            SizedBox(height: 12),
            Text(
              'Unable to play video',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  void pauseVideo() {
    if (state is VideoPlayerLoaded) {
      final loaded = state as VideoPlayerLoaded;
      loaded.videoController.pause();
    }
  }

  void resumeVideo() {
    if (state is VideoPlayerLoaded) {
      final loaded = state as VideoPlayerLoaded;
      loaded.videoController.play();
    }
  }

  @override
  Future<void> close() {
    if (state is VideoPlayerLoaded) {
      final loaded = state as VideoPlayerLoaded;
      loaded.chewieController.dispose();
      loaded.videoController.dispose();
    }
    return super.close();
  }
}
