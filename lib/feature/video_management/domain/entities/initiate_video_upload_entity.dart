import 'package:equatable/equatable.dart';
import 'thumbnail_signature_entity.dart';
import 'video_signature_entity.dart';

class InitiateVideoUploadEntity extends Equatable {
  final String videoId;
  final VideoSignatureEntity signatureVideoData;
  final ThumbnailSignatureEntity signatureThumbnailData;

  const InitiateVideoUploadEntity({
    required this.videoId,
    required this.signatureVideoData,
    required this.signatureThumbnailData,
  });

  @override
  List<Object?> get props => [
        videoId,
        signatureVideoData,
        signatureThumbnailData,
      ];
}