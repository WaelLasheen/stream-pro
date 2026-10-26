import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/watch_later/domain/repositories/watch_later_repository.dart';

class ToggleWatchLaterUseCase {
  final WatchLaterRepository repository;

  ToggleWatchLaterUseCase(this.repository);

  Future<Either<Failure, bool>> call({required String videoId}) {
    return repository.toggleWatchLater(videoId);
  }
}
