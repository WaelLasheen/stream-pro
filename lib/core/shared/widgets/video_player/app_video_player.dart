import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/observers/app_route_observer.dart';
import 'package:stream_pro/core/shared/widgets/video_player/controller/video_player_cubit.dart';
import 'package:stream_pro/core/shared/widgets/video_player/controller/video_player_state.dart';
import 'package:stream_pro/core/shared/widgets/video_player/video_player_data.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final VideoPlayerData data;
  final double? aspectRatio;
  final double? width;

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

class _AppVideoPlayerState extends State<AppVideoPlayer> with RouteAware {
  late final VideoPlayerCubit _cubit;
  AppLifecycleListener? _lifecycleListener;
  bool _wasPlayingBeforePause = false;
  bool _wasPlaying = false;
  bool _isInitialized = false;

  VideoPlayerController? _activeController;

  void _pause() {
    final controller = _cubit.state.videoController;
    if (controller != null) {
      _wasPlayingBeforePause = controller.value.isPlaying;
    }
    _cubit.pauseVideo();
  }

  void _resume() {
    if (_wasPlayingBeforePause) {
      _cubit.resumeVideo();
    }
  }

  void _onPlayerStateChanged() {
    if (!mounted) return;

    final controller = _cubit.state.videoController;
    if (controller == null) return;

    final position = controller.value.position;
    final isPlaying = controller.value.isPlaying;
    final isCompleted =
        position >= controller.value.duration &&
        controller.value.duration.inSeconds > 0;

    if (!_isInitialized) {
      _isInitialized = true;
      widget.onInitialized?.call();
    }

    widget.onPositionChanged?.call(position);

    if (_wasPlaying != isPlaying) {
      widget.onPlayStateChanged?.call(isPlaying);
      _wasPlaying = isPlaying;
    }

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _activeController?.removeListener(_onPlayerStateChanged);

    _lifecycleListener?.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  void didPushNext() {
    _pause();
  }

  @override
  void didPopNext() {
    _resume();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<VideoPlayerCubit, VideoPlayerState>(
        listener: (context, state) {
          final newController = state.videoController;

          if (_activeController != newController) {
            _activeController?.removeListener(_onPlayerStateChanged);
            _activeController = newController;
            _activeController?.addListener(_onPlayerStateChanged);
          }
        },
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
        return Chewie(controller: state.chewieController!);

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
