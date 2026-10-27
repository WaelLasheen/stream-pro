import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/watch_later/domain/entities/watch_later_feed_entity.dart';
import 'package:stream_pro/feature/watch_later/domain/repositories/watch_later_repository.dart';

class GetWatchLaterUseCase {
  final WatchLaterRepository repository;

  GetWatchLaterUseCase(this.repository);

  Future<Either<Failure, WatchLaterFeedEntity>> call({String? cursor}) {
    return repository.getWatchLater(cursor: cursor);
  }
}
