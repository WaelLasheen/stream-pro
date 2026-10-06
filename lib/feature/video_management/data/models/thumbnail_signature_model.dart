import '../../domain/entities/thumbnail_signature_entity.dart';

class ThumbnailSignatureModel {
  final int timestamp;
  final String folder;
  final String publicId;
  final String transformation;
  final String signature;
  final String apiKey;
  final String uploadUrl;

  const ThumbnailSignatureModel({
    required this.timestamp,
    required this.folder,
    required this.publicId,
    required this.transformation,
    required this.signature,
    required this.apiKey,
    required this.uploadUrl,
  });

  factory ThumbnailSignatureModel.fromJson(Map<String, dynamic> json) {
    return ThumbnailSignatureModel(
      timestamp: json['timestamp'] as int? ?? 0,
      folder: json['folder'] as String? ?? '',
      publicId: json['public_id'] as String? ?? '',
      transformation: json['transformation'] as String? ?? '',
      signature: json['signature'] as String? ?? '',
      apiKey: json['apiKey'] as String? ?? '',
      uploadUrl: json['uploadUrl'] as String? ?? '',
    );
  }

  ThumbnailSignatureEntity toEntity() {
    return ThumbnailSignatureEntity(
      timestamp: timestamp,
      folder: folder,
      publicId: publicId,
      transformation: transformation,
      signature: signature,
      apiKey: apiKey,
      uploadUrl: uploadUrl,
    );
  }
}