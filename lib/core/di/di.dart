import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_pro/core/app_config/app_config_cubit.dart';
import 'package:stream_pro/core/live_error_logger/crashlytics_service.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/networking/api_service_impl.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/notifications/notification_service_impl.dart';
import 'package:stream_pro/core/routing/app_router.dart';
import 'package:stream_pro/core/routing/notification_router.dart';
import 'package:stream_pro/core/storage/local_storage_service.dart';
import 'package:stream_pro/core/storage/local_storage_service_impl.dart';
import 'package:stream_pro/core/storage/secure_storage_service.dart';
import 'package:stream_pro/core/storage/secure_storage_service_impl.dart';
import 'package:stream_pro/core/storage/token_storage_service.dart';
import 'package:stream_pro/core/utils/observers/app_bloc_observer.dart';
import 'package:stream_pro/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:stream_pro/feature/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:stream_pro/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/home/data/datasources/home_remote_datasource.dart';
import 'package:stream_pro/feature/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:stream_pro/firebase_options.dart';
import 'package:stream_pro/feature/home/data/repositories/home_repository_impl.dart';
import 'package:stream_pro/feature/home/domain/repositories/home_repository.dart';
import 'package:stream_pro/feature/home/domain/use_cases/get_feed_use_case.dart';
import 'package:stream_pro/feature/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:stream_pro/feature/video_details/data/datasources/comments_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/datasources/likes_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/datasources/video_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/repositories/video_details_repository_impl.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/add_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/delete_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_comments_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_video_details_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/toggle_like_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/update_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_likes_cubit/video_likes_cubit.dart';

final getIt = GetIt.instance;

void setUpBlocObserver() => Bloc.observer = AppBlocObserver();

Future<void> setUpStorage() async {
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  await getIt.isReady<SharedPreferences>();
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(getIt<FlutterSecureStorage>()),
  );
  getIt.registerLazySingleton<TokenStorageService>(
    () => TokenStorageService(getIt<SecureStorageService>()),
  );
}

Future<void> setUpApiService() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(getIt<Dio>(), getIt<TokenStorageService>()),
  );

  await getIt<ApiService>().initialize();
}

Future<void> setupErrorLoggerService() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  getIt.registerLazySingleton<CrashlyticsService>(
    () => CrashlyticsServiceImpl(),
  );
  await getIt<CrashlyticsService>().init();
}

Future<void> setUpNotifications() async {
  getIt.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(),
  );
  await getIt<NotificationService>().initialize();
  getIt<NotificationService>().setOnNotificationTap((data) {
    NotificationRouter.handleNotificationTap(data);
  });
}

void setUpConfig() {
  getIt.registerLazySingleton<AppConfigCubit>(
    () => AppConfigCubit(getIt<LocalStorageService>()),
  );
}

void setUpRouter() {
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}

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
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
}

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

void setUpVideoDetails() {
  // DataSources
  getIt.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<LikesRemoteDataSource>(
    () => LikesRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(getIt<ApiService>()),
  );

  // Repository
  getIt.registerLazySingleton<VideoDetailsRepository>(
    () => VideoDetailsRepositoryImpl(
      videoRemoteDataSource: getIt<VideoRemoteDataSource>(),
      likesRemoteDataSource: getIt<LikesRemoteDataSource>(),
      commentsRemoteDataSource: getIt<CommentsRemoteDataSource>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton(
    () => GetVideoDetailsUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => ToggleLikeUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetCommentsUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => AddCommentUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateCommentUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteCommentUseCase(getIt<VideoDetailsRepository>()),
  );

  // Cubits
  getIt.registerFactory(
    () => VideoDetailsCubit(getIt<GetVideoDetailsUseCase>()),
  );
  getIt.registerFactory(() => VideoLikesCubit(getIt<ToggleLikeUseCase>()));
  getIt.registerFactory(
    () => VideoCommentsCubit(
      getCommentsUseCase: getIt<GetCommentsUseCase>(),
      addCommentUseCase: getIt<AddCommentUseCase>(),
      updateCommentUseCase: getIt<UpdateCommentUseCase>(),
      deleteCommentUseCase: getIt<DeleteCommentUseCase>(),
    ),
  );
}

Future<void> setUpLocators() async {
  setUpBlocObserver();
  await setUpStorage();
  await setUpApiService();
  await setupErrorLoggerService();
  await setUpNotifications();
  setUpConfig();
  setUpRouter();
  setUpAuth();
  setUpHome();
  setUpVideoDetails();
}
