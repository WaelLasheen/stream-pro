import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_pro/core/app_config/app_config_cubit.dart';
import 'package:stream_pro/core/live_error_logger/crashlytics_service.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/networking/api_service_impl.dart';
import 'package:stream_pro/core/networking/raw_api_service.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/notifications/notification_service_impl.dart';
import 'package:stream_pro/core/routing/app_router.dart';
import 'package:stream_pro/core/routing/notification_router.dart';
import 'package:stream_pro/core/services/device/device_info_service.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service_impl.dart';
import 'package:stream_pro/core/services/google_auth/google_auth_service.dart';
import 'package:stream_pro/core/services/google_auth/google_auth_service_impl.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/services/storage/local_storage_service.dart';
import 'package:stream_pro/core/services/storage/local_storage_service_impl.dart';
import 'package:stream_pro/core/services/storage/secure_storage_service.dart';
import 'package:stream_pro/core/services/storage/secure_storage_service_impl.dart';
import 'package:stream_pro/core/services/storage/token_storage_service.dart';
import 'package:stream_pro/core/utils/observers/app_bloc_observer.dart';
import 'package:stream_pro/firebase_options.dart';
import '../di.dart';

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
  getIt.registerLazySingleton<Dio>(() => Dio(), instanceName: 'mainDio');
  getIt.registerLazySingleton<Dio>(() => Dio(), instanceName: 'rawDio');

  getIt.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(
      getIt<Dio>(instanceName: 'mainDio'),
      getIt<TokenStorageService>(),
    ),
  );

  await getIt<ApiService>().initialize();

  getIt.registerLazySingleton<RawApiService>(
    () => RawApiServiceImpl(getIt<Dio>(instanceName: 'rawDio')),
  );
}

Future<void> firebaseInitializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> setupErrorLoggerService() async {
  getIt.registerLazySingleton<CrashlyticsService>(
    () => CrashlyticsServiceImpl(),
  );
  await getIt<CrashlyticsService>().init();
}

Future<void> setUpNotificationService() async {
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

void setUpFilePicker() {
  getIt.registerLazySingleton<FilePickerService>(() => FilePickerServiceImpl());
}

void setUpDeviceInfo() {
  getIt.registerLazySingleton<DeviceInfoService>(() => DeviceInfoServiceImpl());
}

void setUpGoogleAuth() {
  getIt.registerLazySingleton<GoogleAuthService>(() => GoogleAuthServiceImpl());
}
