import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/managed_video_entity.dart';
import '../repositories/video_management_repository.dart';

class GetManagedVideoUseCase {
  final VideoManagementRepository repository;

  GetManagedVideoUseCase(this.repository);

  Future<Either<Failure, ManagedVideoEntity>> call(String videoId) {
    return repository.getVideo(videoId);
  }
}
