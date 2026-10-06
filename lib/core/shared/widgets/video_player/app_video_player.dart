import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/video_player/controller/video_player_cubit.dart';
import 'package:stream_pro/core/shared/widgets/video_player/controller/video_player_state.dart';
import 'package:stream_pro/core/shared/widgets/video_player/video_player_data.dart';

class AppVideoPlayer extends StatefulWidget {
  final VideoPlayerData data;
  final double? aspectRatio;
  final double? width;

  const AppVideoPlayer({
    super.key,
    required this.data,
    this.aspectRatio,
    this.width,
  });

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late final VideoPlayerCubit _cubit;
  AppLifecycleListener? _lifecycleListener;
  bool _wasPlayingBeforePause = false;

  void _pause() {
    if (_cubit.state is VideoPlayerLoaded) {
      final loaded = _cubit.state as VideoPlayerLoaded;
      _wasPlayingBeforePause = loaded.videoController.value.isPlaying;
    }
    _cubit.pauseVideo();
  }

  void _resume() {
    if (_wasPlayingBeforePause) {
      _cubit.resumeVideo();
    }
  }

  @override
  void initState() {
    super.initState();
    _cubit = VideoPlayerCubit();

    _cubit.initializeVideo(widget.data.videoUrl, widget.data.posterUrl);

    _lifecycleListener = AppLifecycleListener(
      onPause: _pause,
      onInactive: _pause,
      onResume: _resume,
    );
  }

  @override
  void dispose() {
    _lifecycleListener?.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          final aspectRatio = widget.aspectRatio ?? 16 / 9;

          return SizedBox(
            width: widget.width ?? double.infinity,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                color: Colors.black,
                child: _buildContent(state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(VideoPlayerState state) {
    switch (state) {
      case VideoPlayerInitial() || VideoPlayerLoading():
        return _buildLoadingThumbnail(widget.data.posterUrl);
        
      case VideoPlayerLoaded():
        return Chewie(controller: state.chewieController);
        
      case VideoPlayerError():
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.white70, size: 48),
              SizedBox(height: 12.h),
              Text(
                'Unable to play video',
                style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }

  Widget _buildLoadingThumbnail(String? posterUrl) {
    if (posterUrl != null && posterUrl.isNotEmpty) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.black.withValues(alpha: 0.4)),
          const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      );
    }
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
