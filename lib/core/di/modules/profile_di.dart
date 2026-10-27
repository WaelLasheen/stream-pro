import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/feature/auth/domain/use_case/logout_use_case.dart';
import 'package:stream_pro/feature/profile/data/datasources/profile_remote_datasource.dart';
import 'package:stream_pro/feature/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:stream_pro/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:stream_pro/feature/profile/domain/repositories/profile_repository.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/delete_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import '../di.dart';

void setUpProfile() {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: getIt<ProfileRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetProfileUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateProfileUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteProfileUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getProfileUseCase: getIt<GetProfileUseCase>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      deleteProfileUseCase: getIt<DeleteProfileUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      sessionCleanupService: getIt<SessionCleanupService>(),
    ),
  );
}
