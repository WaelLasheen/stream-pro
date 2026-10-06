import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/networking/raw_api_service.dart';
import 'package:stream_pro/feature/video_management/data/datasources/video_management_remote_datasource.dart';
import 'package:stream_pro/feature/video_management/data/datasources/video_management_remote_datasource_impl.dart';
import 'package:stream_pro/feature/video_management/data/repositories/video_management_repository_impl.dart';
import 'package:stream_pro/feature/video_management/domain/repositories/video_management_repository.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/change_video_publish_status_use_case.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/change_video_thumbnail_use_case.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/delete_video_use_case.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/get_managed_video_use_case.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/initiate_video_upload_use_case.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/update_video_use_case.dart';
import 'package:stream_pro/feature/video_management/domain/use_cases/upload_video_use_case.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/edit_video_cubit/edit_video_cubit.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/upload_video_cubit/upload_video_cubit.dart';
import '../di.dart';

void setUpVideoManagement() {
  getIt.registerLazySingleton<VideoManagementRemoteDataSource>(
    () => VideoManagementRemoteDataSourceImpl(
      getIt<ApiService>(),
      getIt<RawApiService>(),
    ),
  );

  getIt.registerLazySingleton<VideoManagementRepository>(
    () => VideoManagementRepositoryImpl(
      remoteDataSource: getIt<VideoManagementRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => InitiateVideoUploadUseCase(getIt<VideoManagementRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadVideoUseCase(getIt<VideoManagementRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetManagedVideoUseCase(getIt<VideoManagementRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateVideoUseCase(getIt<VideoManagementRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteVideoUseCase(getIt<VideoManagementRepository>()),
  );
  getIt.registerLazySingleton(
    () => ChangeVideoPublishStatusUseCase(getIt<VideoManagementRepository>()),
  );
  getIt.registerLazySingleton(
    () => ChangeVideoThumbnailUseCase(getIt<VideoManagementRepository>()),
  );

  getIt.registerFactory(
    () => EditVideoCubit(
      getManagedVideoUseCase: getIt<GetManagedVideoUseCase>(),
      updateVideoUseCase: getIt<UpdateVideoUseCase>(),
      deleteVideoUseCase: getIt<DeleteVideoUseCase>(),
      changePublishStatusUseCase: getIt<ChangeVideoPublishStatusUseCase>(),
      changeThumbnailUseCase: getIt<ChangeVideoThumbnailUseCase>(),
    ),
  );
  getIt.registerFactory(() => UploadVideoCubit(getIt<UploadVideoUseCase>()));
}
