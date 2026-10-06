import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/track_watch_history_use_case.dart';
import 'video_track_state.dart';

class VideoTrackCubit extends Cubit<VideoTrackState> {
  final TrackWatchHistoryUseCase trackWatchHistoryUseCase;

  Timer? _periodicTimer;
  String? _currentVideoId;
  int _lastSentSeconds = 0;
  int _currentWatchedSeconds = 0;

  VideoTrackCubit(this.trackWatchHistoryUseCase) : super(VideoTrackInitial());

  /// Call once when starting/playing a video
  void startTracking({required String videoId, int initialWatchedSeconds = 0}) {
    // If switching to a new video, flush the previous one first
    if (_currentVideoId != null && _currentVideoId != videoId) {
      flushCurrentProgress();
    }

    _currentVideoId = videoId;
    _currentWatchedSeconds = initialWatchedSeconds;
    _lastSentSeconds = initialWatchedSeconds;

    _startPeriodicTimer();
  }

  /// Update the current playback position from the player
  void updatePosition(int currentSeconds) {
    _currentWatchedSeconds = currentSeconds;
  }

  /// Triggered on player events: pause, seek, ended, or screen exit
  Future<void> syncProgress({bool force = false}) async {
    if (_currentVideoId == null) return;
    
    // Skip if unchanged unless forced
    if (!force && _currentWatchedSeconds == _lastSentSeconds) return;

    final videoIdToSync = _currentVideoId!;
    final secondsToSync = _currentWatchedSeconds;
    _lastSentSeconds = secondsToSync;

    final result = await trackWatchHistoryUseCase(
      videoId: videoIdToSync,
      watchedSeconds: secondsToSync,
    );

    result.fold(
      (failure) => emit(VideoTrackFailure(failure.message)),
      (_) => emit(VideoTrackSuccess()),
    );
  }

  /// Flush progress immediately (useful for PopScope or dispose)
  Future<void> flushCurrentProgress() async {
    _cancelTimer();
    if (_currentVideoId != null && _currentWatchedSeconds > 0) {
      await syncProgress(force: true);
    }
    _currentVideoId = null;
    _currentWatchedSeconds = 0;
    _lastSentSeconds = 0;
  }

  void _startPeriodicTimer() {
    _cancelTimer();
    // Track every 10 seconds
    _periodicTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (_currentWatchedSeconds != _lastSentSeconds) {
        syncProgress();
      }
    });
  }

  void _cancelTimer() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}