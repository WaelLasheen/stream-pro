import 'package:stream_pro/core/services/session/session_cache.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';

class SessionCacheRegistry {
  final List<SessionCache> _caches = [];

  void register(SessionCache cache) {
    if (_caches.contains(cache)) return;
    _caches.add(cache);
  }

  void clearAll() {
    for (final cache in _caches) {
      try {
        cache.clearSessionCache();
      } catch (error) {
        AppDebuggingPrint.printDebug(
          'Session cache cleanup failed for ${cache.runtimeType}: $error',
        );
      }
    }
  }
}
