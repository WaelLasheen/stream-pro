import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/initiate_video_upload_entity.dart';
import '../params/init_video_params.dart';
import '../repositories/video_management_repository.dart';

class InitiateVideoUploadUseCase {
  final VideoManagementRepository repository;

  InitiateVideoUploadUseCase(this.repository);

  Future<Either<Failure, InitiateVideoUploadEntity>> call(
    InitVideoParams params,
  ) {
    return repository.initiateVideoUpload(params);
  }
}
