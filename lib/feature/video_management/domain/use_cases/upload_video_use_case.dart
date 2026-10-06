import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/upload_video_params.dart';
import '../repositories/video_management_repository.dart';

class UploadVideoUseCase {
  final VideoManagementRepository repository;

  UploadVideoUseCase(this.repository);

  Future<Either<Failure, void>> call(UploadVideoParams params) {
    return repository.uploadVideo(params);
  }
}
