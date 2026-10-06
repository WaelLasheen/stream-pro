import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/home/domain/entities/video_entity.dart';
import 'package:stream_pro/feature/home/domain/repositories/home_repository.dart';

class GetFeedUseCase {
  final HomeRepository _repository;
  GetFeedUseCase(this._repository);

  Future<Either<Failure, List<VideoEntity>>> call({
    List<String> excludeIds = const [],
  }) async {
    return await _repository.getFeed(excludeIds: excludeIds);
  }
}
