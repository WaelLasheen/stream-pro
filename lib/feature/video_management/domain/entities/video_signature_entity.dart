import 'package:equatable/equatable.dart';

class VideoSignatureEntity extends Equatable {
  final int timestamp;
  final String folder;
  final String eager;
  final bool eagerAsync;
  final String eagerNotificationUrl;
  final String publicId;
  final String signature;
  final String apiKey;
  final String uploadUrl;

  const VideoSignatureEntity({
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

  @override
  List<Object?> get props => [
    timestamp,
    folder,
    eager,
    eagerAsync,
    eagerNotificationUrl,
    publicId,
    signature,
    apiKey,
    uploadUrl,
  ];
}
