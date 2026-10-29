import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/routing/observers/app_route_observer.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';

class NotificationRouter {
  static const Set<String> _startupRoutes = {
    AppRoutes.splash,
    AppRoutes.login,
    AppRoutes.register,
  };

  static bool _pendingOpenNotifications = false;

  static void handleNotificationTap(Map<String, dynamic> data) {
    AppDebuggingPrint.printDebug('🚀 Processing Notification Data: $data');

    _pendingOpenNotifications = true;
    _openPendingNotificationsIfReady();
  }

  static void openPendingNotifications() {
    _openPendingNotificationsIfReady();
  }

  static void _openPendingNotificationsIfReady() {
    if (!_pendingOpenNotifications) return;

    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    final history = routeHistoryObserver.history;
    if (history.isEmpty) return;

    final currentRoute = history.last.settings.name;
    if (_startupRoutes.contains(currentRoute)) return;

    _pendingOpenNotifications = false;

    if (currentRoute == AppRoutes.notifications) return;

    navigator.pushNamed(AppRoutes.notifications);
  }
}
