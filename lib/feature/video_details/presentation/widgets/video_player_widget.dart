import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/video_track_cubit/video_track_cubit.dart';
import 'package:stream_pro/generated/l10n.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final String videoId;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.videoId,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final AppLifecycleListener _appLifecycleListener;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _hasError = false;
  bool _isLoading = true;
  bool _wasPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _appLifecycleListener = AppLifecycleListener(
      onPause: _pauseVideoAndSync,
      onInactive: _pauseVideoAndSync,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Detect forward navigation: if route is no longer current, pause video
    final route = ModalRoute.of(context);
    if (route?.isCurrent != true) {
      _pauseVideoAndSync();
    }
  }

  void _pauseVideoAndSync() {
    if (_videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
    _syncProgress();
  }

  void _syncProgress() {
    if (!mounted) return;
    try {
      context.read<VideoTrackCubit>().syncProgress(force: true);
    } catch (_) {}
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await _videoPlayerController.initialize();

      // Start tracking in the cubit once initialized
      if (mounted) {
        context.read<VideoTrackCubit>().startTracking(
          videoId: widget.videoId,
          initialWatchedSeconds:
              _videoPlayerController.value.position.inSeconds,
        );
      }

      // Add listener to track playback progress and pause/end events
      _videoPlayerController.addListener(_onPlayerStateChanged);

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return _buildErrorWidget();
        },
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  void _onPlayerStateChanged() {
    if (!mounted || !_videoPlayerController.value.isInitialized) return;

    final position = _videoPlayerController.value.position;
    final isPlaying = _videoPlayerController.value.isPlaying;
    final isCompleted =
        position >= _videoPlayerController.value.duration &&
        _videoPlayerController.value.duration.inSeconds > 0;

    // 1. Keep cubit updated with current position
    context.read<VideoTrackCubit>().updatePosition(position.inSeconds);

    // 2. If user just paused the video, sync progress immediately
    if (_wasPlaying && !isPlaying) {
      context.read<VideoTrackCubit>().syncProgress(force: true);
    }

    // 3. If video ended, sync progress immediately
    if (isCompleted) {
      context.read<VideoTrackCubit>().syncProgress(force: true);
    }

    _wasPlaying = isPlaying;
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16.r),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.redAccent, size: 40.sp),
            SizedBox(height: 8.h),
            Text(
              S.current.videoLoadError,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: _initializePlayer,
              icon: const Icon(Icons.refresh),
              label: Text(S.current.retry),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose(); // Clean up listener
    _pauseVideoAndSync(); // Final pause + sync before disposing
    _videoPlayerController.removeListener(_onPlayerStateChanged);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _hasError
          ? _buildErrorWidget()
          : (_chewieController != null && !_isLoading
                ? Chewie(controller: _chewieController!)
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )),
    );
  }
}
