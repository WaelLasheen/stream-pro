import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/services/session/session_cache_registry.dart';
import 'package:stream_pro/core/services/storage/gallery_service.dart';
import 'package:stream_pro/core/services/storage/gallery_service_impl.dart';
import 'package:stream_pro/feature/video_details/data/datasources/video_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/repositories/video_details_repository_impl.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/download_video_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_related_videos_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_video_details_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/record_video_view_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/download_cubit/download_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/related_videos_cubit/related_videos_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import '../di.dart';

void setUpVideoDetails() {
  getIt.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<GalleryService>(() => const GalleryServiceImpl());

  getIt.registerLazySingleton<VideoDetailsRepository>(() {
    final repository = VideoDetailsRepositoryImpl(
      videoRemoteDataSource: getIt<VideoRemoteDataSource>(),
      galleryService: getIt<GalleryService>(),
    );
    getIt<SessionCacheRegistry>().register(repository);
    return repository;
  });

  getIt.registerLazySingleton(
    () => GetVideoDetailsUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => RecordVideoViewUseCase(getIt<VideoDetailsRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetRelatedVideosUseCase(getIt<VideoDetailsRepository>()),
  );

  getIt.registerLazySingleton(
    () => DownloadVideoUseCase(getIt<VideoDetailsRepository>()),
  );

  getIt.registerFactory(
    () => VideoDetailsCubit(
      getVideoDetailsUseCase: getIt<GetVideoDetailsUseCase>(),
      recordVideoViewUseCase: getIt<RecordVideoViewUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => RelatedVideosCubit(getIt<GetRelatedVideosUseCase>()),
  );
  getIt.registerFactory(
    () => DownloadCubit(downloadVideoUseCase: getIt<DownloadVideoUseCase>()),
  );
}
