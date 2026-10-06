import '../../domain/entities/thumbnail_signature_entity.dart';
import '../../domain/entities/video_signature_entity.dart';
import '../../domain/params/init_video_params.dart';
import '../../domain/params/update_video_params.dart';
import '../models/cloudinary_thumbnail_result_model.dart';
import '../models/cloudinary_video_result_model.dart';
import '../models/complete_thumbnail_upload_request_model.dart';
import '../models/complete_video_upload_request_model.dart';
import '../models/initiate_video_upload_model.dart';
import '../models/managed_video_model.dart';
import '../models/thumbnail_signature_model.dart';

abstract class VideoManagementRemoteDataSource {
  // ── Upload ────────────────────────────────────────────────
  Future<InitiateVideoUploadModel> initiateVideoUpload(InitVideoParams params);

  Future<CloudinaryVideoResultModel> uploadVideoToCloudinary({
    required String filePath,
    required VideoSignatureEntity signatureData,
  });

  Future<CloudinaryThumbnailResultModel> uploadThumbnailToCloudinary({
    required String filePath,
    required ThumbnailSignatureEntity signatureData,
  });

  Future<void> completeVideoUpload({
    required String videoId,
    required CompleteVideoUploadRequestModel request,
  });

  Future<void> completeThumbnailUpload({
    required String videoId,
    required CompleteThumbnailUploadRequestModel request,
  });

  // ── Manage ────────────────────────────────────────────────
  Future<ManagedVideoModel> getVideo(String videoId);

  Future<void> updateVideo(String videoId, UpdateVideoParams params);

  Future<void> deleteVideo(String videoId);

  Future<void> changePublishStatus(String videoId);

  Future<ThumbnailSignatureModel> getThumbnailSignature(String videoId);
}
