import 'package:equatable/equatable.dart';

class ThumbnailSignatureEntity extends Equatable {
  final int timestamp;
  final String folder;
  final String publicId;
  final String transformation;
  final String signature;
  final String apiKey;
  final String uploadUrl;

  const ThumbnailSignatureEntity({
    required this.timestamp,
    required this.folder,
    required this.publicId,
    required this.transformation,
    required this.signature,
    required this.apiKey,
    required this.uploadUrl,
  });

  @override
  List<Object?> get props => [
    timestamp,
    folder,
    publicId,
    transformation,
    signature,
    apiKey,
    uploadUrl,
  ];
}
