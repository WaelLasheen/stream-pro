import '../../domain/entities/cloudinary_thumbnail_result_entity.dart';

class CloudinaryThumbnailResultModel {
  final String publicId;
  final int version;
  final String signature;
  final String secureUrl;

  const CloudinaryThumbnailResultModel({
    required this.publicId,
    required this.version,
    required this.signature,
    required this.secureUrl,
  });

  factory CloudinaryThumbnailResultModel.fromJson(Map<String, dynamic> json) {
    return CloudinaryThumbnailResultModel(
      publicId: json['public_id'] as String? ?? '',
      version: json['version'] as int? ?? 0,
      signature: json['signature'] as String? ?? '',
      secureUrl: json['secure_url'] as String? ?? '',
    );
  }

  CloudinaryThumbnailResultEntity toEntity() {
    return CloudinaryThumbnailResultEntity(
      publicId: publicId,
      version: version,
      signature: signature,
      secureUrl: secureUrl,
    );
  }
}