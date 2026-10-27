import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/watch_history_entity.dart';

abstract class WatchHistoryRepository {
  Future<Either<Failure, List<WatchHistoryEntity>>> getWatchHistory({
    String? cursor,
  });

  Future<Either<Failure, void>> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  });
}
