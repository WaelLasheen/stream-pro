import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/core/services/storage/gallery_service.dart';
import 'package:stream_pro/feature/video_details/data/datasources/video_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/domain/entities/related_video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';

class VideoDetailsRepositoryImpl implements VideoDetailsRepository {
  final VideoRemoteDataSource videoRemoteDataSource;
  final GalleryService galleryService;
  final Set<String> _videoIdsWithViewRecorded = {};

  VideoDetailsRepositoryImpl({
    required this.videoRemoteDataSource,
    required this.galleryService,
  });

  @override
  Future<Either<Failure, VideoEntity>> getVideoDetails(String videoId) {
    return safeCall(() async {
      final response = await videoRemoteDataSource.getVideoDetails(videoId);
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> recordVideoView(String videoId) {
    if (_videoIdsWithViewRecorded.contains(videoId)) {
      return Future.value(const Right(null));
    }
    _videoIdsWithViewRecorded.add(videoId);
    return safeCall(() async {
      await videoRemoteDataSource.recordVideoView(videoId);
    });
  }

  @override
  Future<Either<Failure, List<RelatedVideoEntity>>> getRelatedVideos(
    String videoId,
  ) {
    return safeCall(() async {
      final response = await videoRemoteDataSource.getRelatedVideos(videoId);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> downloadVideo({
    required String videoId,
    void Function(int count, int total)? onReceiveProgress,
  }) {
    return safeCall(() async {
      final directory = await getApplicationDocumentsDirectory();
      final tempSavePath = '${directory.path}/$videoId.mp4';

      try {
        await videoRemoteDataSource.downloadVideo(
          videoId: videoId,
          savePath: tempSavePath,
          onReceiveProgress: onReceiveProgress,
        );

        await galleryService.saveVideo(tempSavePath);
      } finally {
        final tempFile = File(tempSavePath);
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
      }
    });
  }
}
