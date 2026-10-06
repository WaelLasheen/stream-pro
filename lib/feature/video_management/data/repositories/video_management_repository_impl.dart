import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/initiate_video_upload_entity.dart';
import '../../domain/entities/managed_video_entity.dart';
import '../../domain/entities/upload_video_params.dart';
import '../../domain/params/init_video_params.dart';
import '../../domain/params/update_video_params.dart';
import '../../domain/repositories/video_management_repository.dart';
import '../datasources/video_management_remote_datasource.dart';
import '../models/complete_thumbnail_upload_request_model.dart';
import '../models/complete_video_upload_request_model.dart';

class VideoManagementRepositoryImpl implements VideoManagementRepository {
  final VideoManagementRemoteDataSource remoteDataSource;

  VideoManagementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, InitiateVideoUploadEntity>> initiateVideoUpload(
    InitVideoParams params,
  ) {
    return safeCall(() async {
      final model = await remoteDataSource.initiateVideoUpload(params);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> uploadVideo(UploadVideoParams params) {
    return safeCall(() async {
      // 1. Initiate: create the video record + get Cloudinary signatures
      final initiateModel = await remoteDataSource.initiateVideoUpload(
        params.initParams,
      );

      // 2. Upload the video file
      final videoResult = await remoteDataSource.uploadVideoToCloudinary(
        filePath: params.videoFilePath,
        signatureData: initiateModel.signatureVideoData.toEntity(),
      );

      // 3. Upload the thumbnail
      final thumbnailResult = await remoteDataSource.uploadThumbnailToCloudinary(
        filePath: params.thumbnailFilePath,
        signatureData: initiateModel.signatureThumbnailData.toEntity(),
      );

      // 4. Tell the backend the video upload finished
      await remoteDataSource.completeVideoUpload(
        videoId: initiateModel.videoId,
        request: CompleteVideoUploadRequestModel(
          publicId: videoResult.publicId,
          version: videoResult.version,
          signature: videoResult.signature,
          duration: videoResult.duration,
          bytes: videoResult.bytes,
        ),
      );

      // 5. Tell the backend the thumbnail upload finished
      await remoteDataSource.completeThumbnailUpload(
        videoId: initiateModel.videoId,
        request: CompleteThumbnailUploadRequestModel(
          publicId: thumbnailResult.publicId,
          version: thumbnailResult.version,
          signature: thumbnailResult.signature,
          thumbnailUrl: thumbnailResult.secureUrl,
        ),
      );
    });
  }

  @override
  Future<Either<Failure, ManagedVideoEntity>> getVideo(String videoId) {
    return safeCall(() async {
      final model = await remoteDataSource.getVideo(videoId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> updateVideo(
    String videoId,
    UpdateVideoParams params,
  ) {
    return safeCall(() => remoteDataSource.updateVideo(videoId, params));
  }

  @override
  Future<Either<Failure, void>> deleteVideo(String videoId) {
    return safeCall(() => remoteDataSource.deleteVideo(videoId));
  }

  @override
  Future<Either<Failure, void>> changePublishStatus(String videoId) {
    return safeCall(() => remoteDataSource.changePublishStatus(videoId));
  }

  @override
  Future<Either<Failure, String>> changeThumbnail({
    required String videoId,
    required String filePath,
  }) {
    return safeCall(() async {
      // 1. Ask the backend for a fresh signed upload for this video's thumbnail
      final signature = await remoteDataSource.getThumbnailSignature(videoId);

      // 2. Upload the new image to Cloudinary
      final result = await remoteDataSource.uploadThumbnailToCloudinary(
        filePath: filePath,
        signatureData: signature.toEntity(),
      );

      // 3. Confirm with the backend (same endpoint the upload flow uses)
      await remoteDataSource.completeThumbnailUpload(
        videoId: videoId,
        request: CompleteThumbnailUploadRequestModel(
          publicId: result.publicId,
          version: result.version,
          signature: result.signature,
          thumbnailUrl: result.secureUrl,
        ),
      );

      return result.secureUrl;
    });
  }
}
