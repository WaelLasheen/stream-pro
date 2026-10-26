import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_feed_entity.dart';

abstract class WatchLaterRepository {
  Future<Either<Failure, WatchLaterFeedEntity>> getWatchLater();
  Future<Either<Failure, bool>> isInWatchLater(String videoId);
  Future<Either<Failure, bool>> toggleWatchLater(String videoId);
}
