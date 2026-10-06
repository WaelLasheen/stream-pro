import '../../domain/entities/video_signature_entity.dart';

class VideoSignatureModel {
  final int timestamp;
  final String folder;
  final String eager;
  final bool eagerAsync;
  final String eagerNotificationUrl;
  final String publicId;
  final String signature;
  final String apiKey;
  final String uploadUrl;

  const VideoSignatureModel({
    required this.timestamp,
    required this.folder,
    required this.eager,
    required this.eagerAsync,
    required this.eagerNotificationUrl,
    required this.publicId,
    required this.signature,
    required this.apiKey,
    required this.uploadUrl,
  });

  factory VideoSignatureModel.fromJson(Map<String, dynamic> json) {
    return VideoSignatureModel(
      timestamp: json['timestamp'] as int? ?? 0,
      folder: json['folder'] as String? ?? '',
      eager: json['eager'] as String? ?? '',
      eagerAsync: json['eager_async'] as bool? ?? false,
      eagerNotificationUrl: json['eager_notification_url'] as String? ?? '',
      publicId: json['public_id'] as String? ?? '',
      signature: json['signature'] as String? ?? '',
      apiKey: json['apiKey'] as String? ?? '',
      uploadUrl: json['uploadUrl'] as String? ?? '',
    );
  }

  VideoSignatureEntity toEntity() {
    return VideoSignatureEntity(
      timestamp: timestamp,
      folder: folder,
      eager: eager,
      eagerAsync: eagerAsync,
      eagerNotificationUrl: eagerNotificationUrl,
      publicId: publicId,
      signature: signature,
      apiKey: apiKey,
      uploadUrl: uploadUrl,
    );
  }
}