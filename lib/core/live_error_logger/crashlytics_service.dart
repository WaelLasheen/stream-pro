import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// Interface
abstract class CrashlyticsService {
  Future<void> init();
  Future<void> logFatal(dynamic error, StackTrace stackTrace);
  Future<void> logNonFatal(
    dynamic error,
    StackTrace stackTrace, {
    String? reason,
  });
}

// Implementation
class CrashlyticsServiceImpl implements CrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  Future<void> init() async {    await _crashlytics.setCrashlyticsCollectionEnabled(true);
  }

  @override
  Future<void> logFatal(dynamic error, StackTrace stackTrace) async {
    await _crashlytics.recordError(error, stackTrace, fatal: true);
  }

  @override
  Future<void> logNonFatal(
    dynamic error,
    StackTrace stackTrace, {
    String? reason,
  }) async {
    if (reason != null) {
      await _crashlytics.log(reason);
    }
    await _crashlytics.recordError(error, stackTrace, fatal: false);
  }
}
