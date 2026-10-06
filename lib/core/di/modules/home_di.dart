import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/home/data/datasources/home_remote_datasource.dart';
import 'package:stream_pro/feature/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:stream_pro/feature/home/data/repositories/home_repository_impl.dart';
import 'package:stream_pro/feature/home/domain/repositories/home_repository.dart';
import 'package:stream_pro/feature/home/domain/use_cases/get_feed_use_case.dart';
import 'package:stream_pro/feature/home/presentation/controller/home_cubit/home_cubit.dart';
import '../di.dart';

void setUpHome() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetFeedUseCase>(
    () => GetFeedUseCase(getIt<HomeRepository>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getFeedUseCase: getIt<GetFeedUseCase>()),
  );
}