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

  // Tracking callbacks
  final VoidCallback? onInitialized;
  final ValueChanged<Duration>? onPositionChanged;
  final ValueChanged<bool>? onPlayStateChanged;
  final VoidCallback? onVideoCompleted;

  const AppVideoPlayer({
    super.key,
    required this.data,
    this.aspectRatio,
    this.width,
    this.onInitialized,
    this.onPositionChanged,
    this.onPlayStateChanged,
    this.onVideoCompleted,
  });

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late final VideoPlayerCubit _cubit;
  AppLifecycleListener? _lifecycleListener;
  bool _wasPlayingBeforePause = false;
  bool _wasPlaying = false;
  bool _isInitialized = false;

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

  // Listener for tracking
  void _onPlayerStateChanged() {
    final currentState = _cubit.state;
    if (!mounted || currentState is! VideoPlayerLoaded) return;

    final position = currentState.videoController.value.position;
    final isPlaying = currentState.videoController.value.isPlaying;
    final isCompleted =
        position >= currentState.videoController.value.duration &&
        currentState.videoController.value.duration.inSeconds > 0;

    // 1. Trigger initialization callback exactly once
    if (!_isInitialized) {
      _isInitialized = true;
      widget.onInitialized?.call();
    }

    // 2. Update position
    widget.onPositionChanged?.call(position);

    // 3. Detect play/pause state change
    if (_wasPlaying != isPlaying) {
      widget.onPlayStateChanged?.call(isPlaying);
      _wasPlaying = isPlaying;
    }

    // 4. Detect video end
    if (isCompleted) {
      widget.onVideoCompleted?.call();
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

    // Attach listener to the controller once it's loaded
    _cubit.stream.listen((state) {
      if (state is VideoPlayerLoaded) {
        state.videoController.addListener(_onPlayerStateChanged);
      }
    });
  }

  @override
  void dispose() {
    // Clean up listener
    if (_cubit.state is VideoPlayerLoaded) {
      final loaded = _cubit.state as VideoPlayerLoaded;
      loaded.videoController.removeListener(_onPlayerStateChanged);
    }
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
