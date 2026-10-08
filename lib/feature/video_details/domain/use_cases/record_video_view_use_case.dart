import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class RecordVideoViewUseCase {
  final VideoDetailsRepository repository;

  RecordVideoViewUseCase(this.repository);

  Future<Either<Failure, void>> call(String params) {
    return repository.recordVideoView(params);
  }
}
