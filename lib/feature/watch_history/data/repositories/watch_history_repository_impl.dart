import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/watch_history_group_entity.dart';
import '../../domain/entities/watch_history_tracked_item_entity.dart';
import '../../domain/repositories/watch_history_repository.dart';
import '../datasources/watch_history_remote_datasource.dart';

class WatchHistoryRepositoryImpl implements WatchHistoryRepository {
  final WatchHistoryRemoteDataSource remoteDataSource;

  WatchHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WatchHistoryGroupEntity>>> getWatchHistory() {
    return safeCall(() async {
      final models = await remoteDataSource.getWatchHistory();
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, WatchHistoryTrackedItemEntity>> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.trackWatchHistory(
        videoId: videoId,
        watchedSeconds: watchedSeconds,
      );
      return model.toEntity();
    });
  }
}