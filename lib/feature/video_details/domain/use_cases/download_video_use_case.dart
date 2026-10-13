import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class DownloadVideoUseCase {
  final VideoDetailsRepository repository;
  DownloadVideoUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String videoId,
    void Function(int count, int total)? onReceiveProgress,
  }) {
    return repository.downloadVideo(
      videoId: videoId,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
