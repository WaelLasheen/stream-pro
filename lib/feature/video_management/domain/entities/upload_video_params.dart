import 'package:equatable/equatable.dart';
import '../params/init_video_params.dart';

class UploadVideoParams extends Equatable {
  final InitVideoParams initParams;
  final String videoFilePath;
  final String thumbnailFilePath;

  const UploadVideoParams({
    required this.initParams,
    required this.videoFilePath,
    required this.thumbnailFilePath,
  });

  @override
  List<Object?> get props => [
    initParams.title,
    initParams.description,
    initParams.categoryId,
    initParams.tags,
    initParams.publishTime,
    videoFilePath,
    thumbnailFilePath,
  ];
}
