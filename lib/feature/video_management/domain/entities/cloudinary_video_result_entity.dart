import 'package:equatable/equatable.dart';

class CloudinaryVideoResultEntity extends Equatable {
  final String publicId;
  final int version;
  final String signature;
  final double duration;
  final int bytes;
  final String? secureUrl;
  final String? playbackUrl;

  const CloudinaryVideoResultEntity({
    required this.publicId,
    required this.version,
    required this.signature,
    required this.duration,
    required this.bytes,
    this.secureUrl,
    this.playbackUrl,
  });

  @override
  List<Object?> get props => [
        publicId,
        version,
        signature,
        duration,
        bytes,
        secureUrl,
        playbackUrl,
      ];
}