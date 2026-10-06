import 'package:dio/dio.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/networking/raw_api_service.dart';
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
import 'video_management_remote_datasource.dart';

class VideoManagementRemoteDataSourceImpl
    implements VideoManagementRemoteDataSource {
  final ApiService _apiService;
  final RawApiService _rawApiService;

  VideoManagementRemoteDataSourceImpl(this._apiService, this._rawApiService);

  @override
  Future<InitiateVideoUploadModel> initiateVideoUpload(
    InitVideoParams params,
  ) async {
    final response = await _apiService.post(
      ApiConstants.initiateVideoUpload,
      data: params.toJson(),
    );
    return InitiateVideoUploadModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<CloudinaryVideoResultModel> uploadVideoToCloudinary({
    required String filePath,
    required VideoSignatureEntity signatureData,
  }) async {
    final fileName = filePath.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'timestamp': signatureData.timestamp,
      'api_key': signatureData.apiKey,
      'signature': signatureData.signature,
      'folder': signatureData.folder,
      'public_id': signatureData.publicId,
      'eager': signatureData.eager,
      'eager_async': signatureData.eagerAsync,
      'eager_notification_url': signatureData.eagerNotificationUrl,
    });

    final response = await _rawApiService.post(
      signatureData.uploadUrl,
      data: formData,
    );
    return CloudinaryVideoResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<CloudinaryThumbnailResultModel> uploadThumbnailToCloudinary({
    required String filePath,
    required ThumbnailSignatureEntity signatureData,
  }) async {
    final fileName = filePath.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'timestamp': signatureData.timestamp,
      'api_key': signatureData.apiKey,
      'signature': signatureData.signature,
      'folder': signatureData.folder,
      'public_id': signatureData.publicId,
      'transformation': signatureData.transformation,
    });

    final response = await _rawApiService.post(
      signatureData.uploadUrl,
      data: formData,
    );
    return CloudinaryThumbnailResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> completeVideoUpload({
    required String videoId,
    required CompleteVideoUploadRequestModel request,
  }) async {
    await _apiService.post(
      ApiConstants.completeVideoUpload(videoId),
      data: request.toJson(),
    );
  }

  @override
  Future<void> completeThumbnailUpload({
    required String videoId,
    required CompleteThumbnailUploadRequestModel request,
  }) async {
    await _apiService.post(
      ApiConstants.completeThumbnailUpload(videoId),
      data: request.toJson(),
    );
  }

  @override
  Future<ManagedVideoModel> getVideo(String videoId) async {
    final response = await _apiService.get(
      ApiConstants.ownerVideoById(videoId),
    );
    return ManagedVideoModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> updateVideo(String videoId, UpdateVideoParams params) async {
    await _apiService.patch(
      ApiConstants.ownerVideoById(videoId),
      data: params.toJson(),
    );
  }

  @override
  Future<void> deleteVideo(String videoId) async {
    await _apiService.delete(ApiConstants.ownerVideoById(videoId));
  }

  @override
  Future<void> changePublishStatus(String videoId) async {
    await _apiService.patch(ApiConstants.changeVideoPublishStatus(videoId));
  }

  @override
  Future<ThumbnailSignatureModel> getThumbnailSignature(String videoId) async {
    final response = await _apiService.patch(
      ApiConstants.videoThumbnailSignature(videoId),
    );
    final data = response.data as Map<String, dynamic>;
    return ThumbnailSignatureModel.fromJson(data);
  }
}
