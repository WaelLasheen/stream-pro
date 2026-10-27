import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/watch_history_entity.dart';
import '../../domain/repositories/watch_history_repository.dart';
import '../datasources/watch_history_remote_datasource.dart';

class WatchHistoryRepositoryImpl implements WatchHistoryRepository {
  final WatchHistoryRemoteDataSource remoteDataSource;

  WatchHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WatchHistoryEntity>>> getWatchHistory({
    String? cursor,
  }) {
    return safeCall(() async {
      final models = await remoteDataSource.getWatchHistory(cursor: cursor);
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> trackWatchHistory({
    required String videoId,
    required int watchedSeconds,
  }) {
    return safeCall(() async {
      await remoteDataSource.trackWatchHistory(
        videoId: videoId,
        watchedSeconds: watchedSeconds,
      );
    });
  }
}
