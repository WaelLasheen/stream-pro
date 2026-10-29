import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/feature/sessions/data/datasources/sessions_remote_datasource.dart';
import 'package:stream_pro/feature/sessions/data/datasources/sessions_remote_datasource_impl.dart';
import 'package:stream_pro/feature/sessions/data/repositories/sessions_repository_impl.dart';
import 'package:stream_pro/feature/sessions/domain/repositories/sessions_repository.dart';
import 'package:stream_pro/feature/sessions/domain/use_cases/get_sessions_use_case.dart';
import 'package:stream_pro/feature/sessions/domain/use_cases/logout_all_sessions_use_case.dart';
import 'package:stream_pro/feature/sessions/domain/use_cases/revoke_session_use_case.dart';
import 'package:stream_pro/feature/sessions/presentation/controllers/sessions_cubit/sessions_cubit.dart';

import '../di.dart';

void setUpSessions() {
  getIt.registerLazySingleton<SessionsRemoteDataSource>(
    () => SessionsRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<SessionsRepository>(
    () => SessionsRepositoryImpl(
      remoteDataSource: getIt<SessionsRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetSessionsUseCase(getIt<SessionsRepository>()),
  );
  getIt.registerLazySingleton(
    () => RevokeSessionUseCase(getIt<SessionsRepository>()),
  );
  getIt.registerLazySingleton(
    () => LogoutAllSessionsUseCase(getIt<SessionsRepository>()),
  );
  getIt.registerFactory<SessionsCubit>(
    () => SessionsCubit(
      getSessionsUseCase: getIt<GetSessionsUseCase>(),
      revokeSessionUseCase: getIt<RevokeSessionUseCase>(),
      logoutAllSessionsUseCase: getIt<LogoutAllSessionsUseCase>(),
      sessionCleanupService: getIt<SessionCleanupService>(),
    ),
  );
}
