import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/services/storage/token_storage_service.dart';
import 'package:stream_pro/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:stream_pro/feature/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:stream_pro/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/refresh_token_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/controller/splash_cubit/splash_cubit.dart';
import '../di.dart';

void setUpAuth() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      notificationService: getIt<NotificationService>(),
      tokenStorage: getIt<TokenStorageService>(),
    ),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(refreshTokenUseCase: getIt<RefreshTokenUseCase>()),
  );
}
