import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/watch_history_group_entity.dart';
import '../entities/watch_history_tracked_item_entity.dart';

abstract class WatchHistoryRepository {
  Future<Either<Failure, List<WatchHistoryGroupEntity>>> getWatchHistory();

  Future<Either<Failure, WatchHistoryTrackedItemEntity>> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  });
}