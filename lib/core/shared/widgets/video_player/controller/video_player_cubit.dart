import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/shared/widgets/video_player/custom_material_controls.dart';
import 'package:stream_pro/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(const VideoPlayerInitial());

  Future<void> initializeVideo(String videoUrl, String? posterUrl) async {
    emit(const VideoPlayerLoading());

    VideoPlayerController? videoController;
    ChewieController? chewieController;

    try {
      videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoController.initialize();

      if (isClosed) {
        await videoController.dispose();
        return;
      }

      final aspectRatio = videoController.value.aspectRatio > 0
          ? videoController.value.aspectRatio
          : 16 / 9;

      chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: true,
        looping: false,
        aspectRatio: aspectRatio,
        playbackSpeeds: const [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0],
        customControls: const CustomMaterialControls(),
        placeholder: Container(color: Colors.black),
        errorBuilder: (context, errorMessage) => _buildErrorWidget(),
      );

      if (isClosed) {
        chewieController.dispose();
        await videoController.dispose();
        return;
      }

      emit(
        VideoPlayerLoaded(
          videoController: videoController,
          chewieController: chewieController,
        ),
      );
    } catch (e) {
      if (videoController != null) {
        try {
          await videoController.dispose();
        } catch (_) {}
      }
      if (isClosed) return;
      emit(VideoPlayerError(e.toString()));
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white70, size: 48),
            const SizedBox(height: 12),
            Text(
              S.current.unableToPlayVideo,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  void pauseVideo() {
    state.videoController?.pause();
  }

  void resumeVideo() {
    state.videoController?.play();
  }

  @override
  Future<void> close() async {
    state.chewieController?.dispose();
    await state.videoController?.dispose();

    return super.close();
  }
}
