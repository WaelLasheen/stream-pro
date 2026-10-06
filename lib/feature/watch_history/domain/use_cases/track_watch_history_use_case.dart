import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/watch_history_tracked_item_entity.dart';
import '../repositories/watch_history_repository.dart';

class TrackWatchHistoryUseCase {
  final WatchHistoryRepository repository;

  TrackWatchHistoryUseCase(this.repository);

  Future<Either<Failure, WatchHistoryTrackedItemEntity>> call({
    required String videoId,
    required int watchedSeconds,
  }) {
    return repository.trackWatchHistory(
      videoId: videoId,
      watchedSeconds: watchedSeconds,
    );
  }
}