import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/watch_history/data/datasources/watch_history_remote_datasource.dart';
import 'package:stream_pro/feature/watch_history/data/datasources/watch_history_remote_datasource_impl.dart';
import 'package:stream_pro/feature/watch_history/data/repositories/watch_history_repository_impl.dart';
import 'package:stream_pro/feature/watch_history/domain/repositories/watch_history_repository.dart';
import 'package:stream_pro/feature/watch_history/domain/use_cases/get_watch_history_use_case.dart';
import 'package:stream_pro/feature/watch_history/domain/use_cases/track_watch_history_use_case.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/video_track_cubit/video_track_cubit.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_cubit.dart';
import '../di.dart';

void setUpWatchHistory() {
  getIt.registerLazySingleton<WatchHistoryRemoteDataSource>(
    () => WatchHistoryRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<WatchHistoryRepository>(
    () => WatchHistoryRepositoryImpl(
      remoteDataSource: getIt<WatchHistoryRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetWatchHistoryUseCase(getIt<WatchHistoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => TrackWatchHistoryUseCase(getIt<WatchHistoryRepository>()),
  );

  getIt.registerFactory(
    () => WatchHistoryCubit(getIt<GetWatchHistoryUseCase>()),
  );
  getIt.registerFactory(
    () => VideoTrackCubit(getIt<TrackWatchHistoryUseCase>()),
  );
}