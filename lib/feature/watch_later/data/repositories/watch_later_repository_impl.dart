import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/feature/watch_later/data/datasources/watch_later_remote_datasource.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_feed_entity.dart';
import 'package:stream_pro/feature/watch_later/domain/repositories/watch_later_repository.dart';

class WatchLaterRepositoryImpl implements WatchLaterRepository {
  final WatchLaterRemoteDataSource remoteDataSource;
  final Map<String, bool> _statusCache = {};

  WatchLaterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WatchLaterFeedEntity>> getWatchLater() {
    return safeCall(() async {
      final model = await remoteDataSource.getWatchLater();
      final feed = model.toEntity();

      for (final item in feed.items) {
        _statusCache[item.video.id] = true;
      }

      return feed;
    });
  }

  @override
  Future<Either<Failure, bool>> isInWatchLater(String videoId) {
    return safeCall(() => _resolveStatus(videoId));
  }

  Future<bool> _resolveStatus(String videoId) async {
    final cachedStatus = _statusCache[videoId];
    if (cachedStatus != null) return cachedStatus;

    final isInWatchLater = await remoteDataSource.isInWatchLater(videoId);
    _statusCache[videoId] = isInWatchLater;
    return isInWatchLater;
  }

  @override
  Future<Either<Failure, bool>> toggleWatchLater(String videoId) {
    return safeCall(() async {
      final isInWatchLater = await _resolveStatus(videoId);

      if (isInWatchLater) {
        await remoteDataSource.removeFromWatchLater(videoId);
        _statusCache[videoId] = false;
        return false;
      }

      await remoteDataSource.addToWatchLater(videoId);
      _statusCache[videoId] = true;
      return true;
    });
  }
}
