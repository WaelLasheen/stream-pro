import '../../domain/entities/cloudinary_video_result_entity.dart';

class CloudinaryVideoResultModel {
  final String publicId;
  final int version;
  final String signature;
  final double duration;
  final int bytes;
  final String? secureUrl;
  final String? playbackUrl;

  const CloudinaryVideoResultModel({
    required this.publicId,
    required this.version,
    required this.signature,
    required this.duration,
    required this.bytes,
    this.secureUrl,
    this.playbackUrl,
  });

  factory CloudinaryVideoResultModel.fromJson(Map<String, dynamic> json) {
    return CloudinaryVideoResultModel(
      publicId: json['public_id'] as String? ?? '',
      version: json['version'] as int? ?? 0,
      signature: json['signature'] as String? ?? '',
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      bytes: json['bytes'] as int? ?? 0,
      secureUrl: json['secure_url'] as String?,
      playbackUrl: json['playback_url'] as String?,
    );
  }

  CloudinaryVideoResultEntity toEntity() {
    return CloudinaryVideoResultEntity(
      publicId: publicId,
      version: version,
      signature: signature,
      duration: duration,
      bytes: bytes,
      secureUrl: secureUrl,
      playbackUrl: playbackUrl,
    );
  }
}
