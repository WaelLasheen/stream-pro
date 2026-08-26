import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/home/domain/entities/feed_section_entity.dart';
import 'package:stream_pro/feature/home/domain/repositories/home_repository.dart';

class GetFeedUseCase {
  final HomeRepository _repository;
  GetFeedUseCase(this._repository);

  Future<Either<Failure, List<FeedSectionEntity>>> call() async {
    return await _repository.getFeed();
  }
}