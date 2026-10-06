import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/watch_history_group_entity.dart';
import '../repositories/watch_history_repository.dart';

class GetWatchHistoryUseCase {
  final WatchHistoryRepository repository;

  GetWatchHistoryUseCase(this.repository);

  Future<Either<Failure, List<WatchHistoryGroupEntity>>> call() {
    return repository.getWatchHistory();
  }
}