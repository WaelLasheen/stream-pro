import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/initiate_video_upload_entity.dart';
import '../entities/managed_video_entity.dart';
import '../entities/upload_video_params.dart';
import '../params/init_video_params.dart';
import '../params/update_video_params.dart';

abstract class VideoManagementRepository {
  // ── Upload ────────────────────────────────────────────────
  Future<Either<Failure, InitiateVideoUploadEntity>> initiateVideoUpload(
    InitVideoParams params,
  );

  /// Full flow: initiate → upload video → upload thumbnail → complete both.
  Future<Either<Failure, void>> uploadVideo(UploadVideoParams params);

  // ── Manage ────────────────────────────────────────────────
  Future<Either<Failure, ManagedVideoEntity>> getVideo(String videoId);

  Future<Either<Failure, void>> updateVideo(
    String videoId,
    UpdateVideoParams params,
  );

  Future<Either<Failure, void>> deleteVideo(String videoId);

  Future<Either<Failure, void>> changePublishStatus(String videoId);

  /// Full flow: get signature → upload image → complete.
  /// Returns the new thumbnail URL.
  Future<Either<Failure, String>> changeThumbnail({
    required String videoId,
    required String filePath,
  });
}
