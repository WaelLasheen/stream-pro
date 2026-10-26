import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/watch_later/data/datasources/watch_later_remote_datasource.dart';
import 'package:stream_pro/feature/watch_later/data/datasources/watch_later_remote_datasource_impl.dart';
import 'package:stream_pro/feature/watch_later/data/repositories/watch_later_repository_impl.dart';
import 'package:stream_pro/feature/watch_later/domain/repositories/watch_later_repository.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/get_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/is_in_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/toggle_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_button_cubit/watch_later_button_cubit.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_cubit.dart';

import '../di.dart';

void setUpWatchLater() {
  getIt.registerLazySingleton<WatchLaterRemoteDataSource>(
    () => WatchLaterRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<WatchLaterRepository>(
    () => WatchLaterRepositoryImpl(
      remoteDataSource: getIt<WatchLaterRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetWatchLaterUseCase>(
    () => GetWatchLaterUseCase(getIt<WatchLaterRepository>()),
  );
  getIt.registerLazySingleton<IsInWatchLaterUseCase>(
    () => IsInWatchLaterUseCase(getIt<WatchLaterRepository>()),
  );
  getIt.registerLazySingleton<ToggleWatchLaterUseCase>(
    () => ToggleWatchLaterUseCase(getIt<WatchLaterRepository>()),
  );

  getIt.registerFactory<WatchLaterCubit>(
    () => WatchLaterCubit(getWatchLaterUseCase: getIt<GetWatchLaterUseCase>()),
  );
  getIt.registerFactory<WatchLaterButtonCubit>(
    () => WatchLaterButtonCubit(
      isInWatchLaterUseCase: getIt<IsInWatchLaterUseCase>(),
      toggleWatchLaterUseCase: getIt<ToggleWatchLaterUseCase>(),
    ),
  );
}
