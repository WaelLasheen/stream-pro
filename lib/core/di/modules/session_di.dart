import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/services/google_auth/google_auth_service.dart';
import 'package:stream_pro/core/services/session/session_cache_registry.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/core/services/storage/local_storage_service.dart';
import 'package:stream_pro/core/services/storage/secure_storage_service.dart';
import '../di.dart';

void setUpSession() {
  getIt.registerLazySingleton<SessionCacheRegistry>(
    () => SessionCacheRegistry(),
  );
  getIt.registerLazySingleton<SessionCleanupService>(
    () => SessionCleanupServiceImpl(
      apiService: getIt<ApiService>(),
      secureStorage: getIt<SecureStorageService>(),
      localStorage: getIt<LocalStorageService>(),
      notificationService: getIt<NotificationService>(),
      googleAuthService: getIt<GoogleAuthService>(),
      sessionCacheRegistry: getIt<SessionCacheRegistry>(),
    ),
  );
}
