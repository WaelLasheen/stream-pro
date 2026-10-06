import '../../domain/entities/initiate_video_upload_entity.dart';
import 'thumbnail_signature_model.dart';
import 'video_signature_model.dart';

class InitiateVideoUploadModel {
  final String videoId;
  final VideoSignatureModel signatureVideoData;
  final ThumbnailSignatureModel signatureThumbnailData;

  const InitiateVideoUploadModel({
    required this.videoId,
    required this.signatureVideoData,
    required this.signatureThumbnailData,
  });

  factory InitiateVideoUploadModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return InitiateVideoUploadModel(
      videoId: data['videoId'] as String? ?? '',
      signatureVideoData: VideoSignatureModel.fromJson(
        data['signatureVideoData'] as Map<String, dynamic>? ?? {},
      ),
      signatureThumbnailData: ThumbnailSignatureModel.fromJson(
        data['signatureThumbnailData'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  InitiateVideoUploadEntity toEntity() {
    return InitiateVideoUploadEntity(
      videoId: videoId,
      signatureVideoData: signatureVideoData.toEntity(),
      signatureThumbnailData: signatureThumbnailData.toEntity(),
    );
  }
}
