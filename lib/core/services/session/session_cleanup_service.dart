import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stream_pro/core/app_config/app_config_cubit.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/services/google_auth/google_auth_service.dart';
import 'package:stream_pro/core/services/session/session_cache_registry.dart';
import 'package:stream_pro/core/services/storage/local_storage_service.dart';
import 'package:stream_pro/core/services/storage/secure_storage_service.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';

abstract class SessionCleanupService {
  Future<void> clearSession();
}

class SessionCleanupServiceImpl implements SessionCleanupService {
  final ApiService _apiService;
  final SecureStorageService _secureStorage;
  final LocalStorageService _localStorage;
  final NotificationService _notificationService;
  final GoogleAuthService _googleAuthService;
  final SessionCacheRegistry _sessionCacheRegistry;

  SessionCleanupServiceImpl({
    required ApiService apiService,
    required SecureStorageService secureStorage,
    required LocalStorageService localStorage,
    required NotificationService notificationService,
    required GoogleAuthService googleAuthService,
    required SessionCacheRegistry sessionCacheRegistry,
  }) : _apiService = apiService,
       _secureStorage = secureStorage,
       _localStorage = localStorage,
       _notificationService = notificationService,
       _googleAuthService = googleAuthService,
       _sessionCacheRegistry = sessionCacheRegistry;

  @override
  Future<void> clearSession() async {
    final savedLocale = await _readPreference(AppConfigCubit.localeKey);
    final savedTheme = await _readPreference(AppConfigCubit.themeKey);

    await _attempt('clear cookies', _apiService.clearCookies);
    await _attempt('clear secure storage', _secureStorage.clearAll);
    await _attempt('clear local storage', _localStorage.clearAll);

    if (savedLocale != null) {
      await _attempt(
        'restore locale',
        () => _localStorage.writeString(
          key: AppConfigCubit.localeKey,
          value: savedLocale,
        ),
      );
    }
    if (savedTheme != null) {
      await _attempt(
        'restore theme',
        () => _localStorage.writeString(
          key: AppConfigCubit.themeKey,
          value: savedTheme,
        ),
      );
    }

    await _attempt(
      'cancel displayed notifications',
      _notificationService.cancelAllNotifications,
    );
    await _attempt('sign out firebase', FirebaseAuth.instance.signOut);
    await _attempt('sign out google', _googleAuthService.signOut);
    await _attempt(
      'clear session caches',
      () async => _sessionCacheRegistry.clearAll(),
    );

    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  Future<String?> _readPreference(String key) async {
    try {
      return await _localStorage.readString(key: key);
    } catch (error) {
      AppDebuggingPrint.printDebug(
        'Session cleanup failed to read preference $key: $error',
      );
      return null;
    }
  }

  Future<void> _attempt(
    String description,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (error) {
      AppDebuggingPrint.printDebug(
        'Session cleanup failed to $description: $error',
      );
    }
  }
}
