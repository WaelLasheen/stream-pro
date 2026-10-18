import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/watch_history_repository.dart';

class TrackWatchHistoryUseCase {
  final WatchHistoryRepository repository;

  TrackWatchHistoryUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String videoId,
    required int watchedSeconds,
  }) {
    return repository.trackWatchHistory(
      videoId: videoId,
      watchedSeconds: watchedSeconds,
    );
  }
}