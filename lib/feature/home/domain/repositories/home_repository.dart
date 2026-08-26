import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/home/domain/entities/feed_section_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<FeedSectionEntity>>> getFeed();
}