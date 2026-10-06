import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/home/domain/entities/video_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<VideoEntity>>> getFeed({
    List<String> excludeIds = const [],
  });
}
