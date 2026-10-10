import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/video_details/data/datasources/video_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/repositories/video_details_repository_impl.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_video_details_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/record_video_view_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import '../di.dart';

void setUpVideoDetails() {
  getIt.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<VideoDetailsRepository>(
    () => VideoDetailsRepositoryImpl(
      videoRemoteDataSource: getIt<VideoRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetVideoDetailsUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => RecordVideoViewUseCase(getIt<VideoDetailsRepository>()),
  );

  getIt.registerFactory(
    () => VideoDetailsCubit(
      getVideoDetailsUseCase: getIt<GetVideoDetailsUseCase>(),
      recordVideoViewUseCase: getIt<RecordVideoViewUseCase>(),
    ),
  );
}
