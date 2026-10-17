import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';
import 'package:video_player/video_player.dart';

class CustomMaterialControls extends StatefulWidget {
  const CustomMaterialControls({super.key});

  @override
  State<CustomMaterialControls> createState() => _CustomMaterialControlsState();
}

class _CustomMaterialControlsState extends State<CustomMaterialControls> {
  late VideoPlayerValue _latestValue;
  Timer? _hideTimer;
  bool _hideStuff = true;
  bool _isInitialized = false;

  late VideoPlayerController controller;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    _latestValue = VideoPlayerValue(
      duration: Duration.zero,
      position: Duration.zero,
      caption: Caption(
        number: 0,
        start: Duration.zero,
        end: Duration.zero,
        text: '',
      ),
      captionOffset: Duration.zero,
      buffered: [],
      isInitialized: false,
      isPlaying: false,
      isLooping: false,
      isBuffering: false,
      volume: 1.0,
      playbackSpeed: 1.0,
      errorDescription: null,
      isCompleted: false,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final chewie = ChewieController.of(context);
    final oldController = _isInitialized ? chewieController : null;

    if (oldController != chewie) {
      if (_isInitialized) {
        controller.removeListener(_updateState);
      }
      chewieController = chewie;
      controller = chewie.videoPlayerController;
      controller.addListener(_updateState);
      _latestValue = controller.value;
      _isInitialized = true;

      if (controller.value.isPlaying) {
        _cancelAndRestartTimer();
      } else if (chewie.showControlsOnInitialize) {
        _cancelAndRestartTimer();
      }
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      controller.removeListener(_updateState);
    }
    _hideTimer?.cancel();
    super.dispose();
  }

  void _updateState() {
    if (!mounted) return;
    setState(() => _latestValue = controller.value);
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();
    if (_hideStuff) {
      setState(() => _hideStuff = false);
    }
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && controller.value.isPlaying) {
        setState(() => _hideStuff = true);
      }
    });
  }

  void _playPause() {
    final isFinished =
        _latestValue.position >= _latestValue.duration &&
        _latestValue.duration.inSeconds > 0;

    setState(() {
      if (controller.value.isPlaying) {
        _hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
      } else {
        _cancelAndRestartTimer();
        if (!controller.value.isInitialized) {
          controller.initialize().then((_) => controller.play());
        } else {
          if (isFinished) controller.seekTo(Duration.zero);
          controller.play();
        }
      }
    });
  }

  void _seekRelative(int seconds) {
    final currentPosition = _latestValue.position;
    final target = currentPosition + Duration(seconds: seconds);
    final clamped = target < Duration.zero ? Duration.zero : target;
    controller.seekTo(clamped);
    _cancelAndRestartTimer();
  }

  void _handleSingleTap() {
    if (_latestValue.isPlaying) {
      setState(() => _hideStuff = !_hideStuff);
      if (!_hideStuff) _startHideTimer();
    } else {
      _playPause();
    }
  }

  void _onExpandCollapse() {
    setState(() => _hideStuff = true);
    chewieController.toggleFullScreen();
    Timer(const Duration(milliseconds: 300), () {
      if (mounted) _cancelAndRestartTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const SizedBox.shrink();

    if (_latestValue.hasError) {
      return chewieController.errorBuilder?.call(
            context,
            _latestValue.errorDescription!,
          ) ??
          const Center(child: Icon(Icons.error, color: Colors.white, size: 42));
    }

    final isFinished =
        _latestValue.position >= _latestValue.duration &&
        _latestValue.duration.inSeconds > 0;
    final isPlaying = _latestValue.isPlaying;

    return MouseRegion(
      onHover: (_) => _cancelAndRestartTimer(),
      child: Stack(
        children: [
          // 1. Double Tap & Single Tap Zones (Always active, even when UI is hidden)
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onDoubleTap: () => _seekRelative(-10),
                  onTap: _handleSingleTap,
                  child: Container(color: Colors.transparent),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onDoubleTap: () => _seekRelative(10),
                  onTap: _handleSingleTap,
                  child: Container(color: Colors.transparent),
                ),
              ),
            ],
          ),

          // 2. Center Play/Pause Button
          Center(
            child: AnimatedOpacity(
              opacity: _hideStuff ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: GestureDetector(
                onTap: _playPause,
                child: SvgPicture.asset(
                  isPlaying && !isFinished
                      ? ImagePath.pauseCircle
                      : ImagePath.playCircle,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 64,
                  height: 64,
                ),
              ),
            ),
          ),

          // 3. Bottom Bar
          Positioned(
            // 🔑 FIX: Positioned is now a DIRECT child of Stack
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              // IgnorePointer is now safely INSIDE Positioned
              ignoring: _hideStuff,
              child: AnimatedOpacity(
                opacity: _hideStuff ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: _buildBottomBarContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarContent(BuildContext context) {
    final isLive = chewieController.isLive;
    final isMuted = _latestValue.volume == 0.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black87],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Tracker
          if (!isLive)
            SizedBox(
              height: 20,
              child: MaterialVideoProgressBar(
                controller,
                colors:
                    chewieController.materialProgressColors ??
                    ChewieProgressColors(
                      playedColor: Colors.red,
                      handleColor: Colors.red,
                      backgroundColor: Colors.white24,
                      bufferedColor: Colors.white12,
                    ),
                onDragStart: () => _hideTimer?.cancel(),
                onDragEnd: _startHideTimer,
              ),
            ),

          // Bottom Action Row
          Row(
            children: [
              _buildPlayPause(),
              _buildPosition(isLive: isLive),
              const Spacer(),

              // 🔊 Mute/Unmute Button
              IconButton(
                icon: SvgPicture.asset(
                  isMuted ? ImagePath.soundMute : ImagePath.sound,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  controller.setVolume(isMuted ? 1.0 : 0.0);
                  _cancelAndRestartTimer();
                },
              ),

              // 🎯 Custom Speed Popup Menu
              _buildSpeedButton(),

              if (chewieController.allowFullScreen) _buildExpandButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayPause() {
    return IconButton(
      icon: SvgPicture.asset(
        _latestValue.isPlaying ? ImagePath.pause : ImagePath.play,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 26,
        height: 26,
      ),
      onPressed: () {
        _cancelAndRestartTimer();
        _playPause();
      },
    );
  }

  Widget _buildPosition({required bool isLive}) {
    final position = _latestValue.position;
    final duration = _latestValue.duration;
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 4),
      child: Text(
        isLive
            ? 'LIVE'
            : '${_formatDuration(position)} / ${_formatDuration(duration)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }

  Widget _buildSpeedButton() {
    final speeds = chewieController.playbackSpeeds;
    final selected = _latestValue.playbackSpeed;

    return AppPopupMenu<double>(
      menuWidth: 140,
      trigger: SvgPicture.asset(
        ImagePath.speedChanger,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 22,
        height: 22,
      ),
      onSelected: (speed) {
        controller.setPlaybackSpeed(speed);
        _cancelAndRestartTimer();
      },
      items: [
        for (final speed in speeds)
          AppMenuItem(
            value: speed,
            title: speed == 1.0 ? 'Normal' : '${speed}x',
            icon: selected == speed ? Icons.check_rounded : null,
          ),
      ],
    );
  }

  Widget _buildExpandButton() {
    return IconButton(
      icon: SvgPicture.asset(
        chewieController.isFullScreen
            ? ImagePath.quitFullScreen
            : ImagePath.fullScreen,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 26,
        height: 26,
      ),
      onPressed: () {
        _cancelAndRestartTimer();
        _onExpandCollapse();
      },
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) return '$hours:$minutes:$seconds';
    return '$minutes:$seconds';
  }
}
