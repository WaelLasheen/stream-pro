import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<VideoEntity>>> getFeed({
    List<String> excludeIds = const [],
  }) async {
    return safeCall(() async {
      final models = await remoteDataSource.getFeed(excludeIds: excludeIds);
      final entities = models.map((model) => model.toEntity()).toList();
      return entities;
    });
  }
}
