class CompleteThumbnailUploadRequestModel {
  final String publicId;
  final int version;
  final String signature;
  final String thumbnailUrl;

  const CompleteThumbnailUploadRequestModel({
    required this.publicId,
    required this.version,
    required this.signature,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'publicId': publicId,
      'version': version,
      'signature': signature,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}