import 'package:equatable/equatable.dart';

class CloudinaryThumbnailResultEntity extends Equatable {
  final String publicId;
  final int version;
  final String signature;
  final String secureUrl;

  const CloudinaryThumbnailResultEntity({
    required this.publicId,
    required this.version,
    required this.signature,
    required this.secureUrl,
  });

  @override
  List<Object?> get props => [
        publicId,
        version,
        signature,
        secureUrl,
      ];
}