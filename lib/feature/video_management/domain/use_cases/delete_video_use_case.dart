import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/video_management_repository.dart';

class DeleteVideoUseCase {
  final VideoManagementRepository repository;

  DeleteVideoUseCase(this.repository);

  Future<Either<Failure, void>> call(String videoId) {
    return repository.deleteVideo(videoId);
  }
}
