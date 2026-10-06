import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../params/update_video_params.dart';
import '../repositories/video_management_repository.dart';

class UpdateVideoUseCase {
  final VideoManagementRepository repository;

  UpdateVideoUseCase(this.repository);

  Future<Either<Failure, void>> call(String videoId, UpdateVideoParams params) {
    return repository.updateVideo(videoId, params);
  }
}
