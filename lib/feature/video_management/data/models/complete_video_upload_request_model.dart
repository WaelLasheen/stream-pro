class CompleteVideoUploadRequestModel {
  final String publicId;
  final int version;
  final String signature;
  final double duration;
  final int bytes;

  const CompleteVideoUploadRequestModel({
    required this.publicId,
    required this.version,
    required this.signature,
    required this.duration,
    required this.bytes,
  });

  Map<String, dynamic> toJson() {
    return {
      'publicId': publicId,
      'version': version,
      'signature': signature,
      'duration': duration,
      'bytes': bytes,
    };
  }
}