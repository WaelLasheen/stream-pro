import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../repositories/video_management_repository.dart';

class ChangeVideoThumbnailUseCase {
  final VideoManagementRepository repository;

  ChangeVideoThumbnailUseCase(this.repository);

  /// Returns the new thumbnail URL.
  Future<Either<Failure, String>> call({
    required String videoId,
    required String filePath,
  }) {
    return repository.changeThumbnail(videoId: videoId, filePath: filePath);
  }
}
