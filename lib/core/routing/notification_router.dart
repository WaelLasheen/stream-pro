import 'dart:async';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/routing/notification_destination.dart';
import 'package:stream_pro/core/routing/observers/app_route_observer.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';
import 'package:stream_pro/feature/notifications/domain/entities/notification_type_enum.dart';
import 'package:stream_pro/feature/notifications/domain/use_cases/mark_notifications_use_cases.dart';

class NotificationRouter {
  static const Set<String> _startupRoutes = {
    AppRoutes.splash,
    AppRoutes.login,
    AppRoutes.register,
  };

  static Map<String, dynamic>? _pendingPayload;

  static void handleNotificationTap(Map<String, dynamic> data) {
    AppDebuggingPrint.printDebug('🚀 Processing Notification Data: $data');

    _pendingPayload = data;
    _openPendingNotificationIfReady();
  }

  static void openPendingNotifications() {
    _openPendingNotificationIfReady();
  }

  static void _openPendingNotificationIfReady() {
    final payload = _pendingPayload;
    if (payload == null) return;

    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    final history = routeHistoryObserver.history;
    if (history.isEmpty) return;

    final currentRoute = history.last.settings.name;
    if (_startupRoutes.contains(currentRoute)) return;

    _pendingPayload = null;

    unawaited(_markAsRead(payload));

    final destination = _resolveDestination(payload);
    if (destination != null) {
      navigator.pushNamed(destination.route, arguments: destination.arguments);
      return;
    }

    if (currentRoute != AppRoutes.notifications) {
      navigator.pushNamed(AppRoutes.notifications);
    }
  }

  static NotificationDestination? _resolveDestination(
    Map<String, dynamic> data,
  ) {
    final type = NotificationType.fromString(data['type']?.toString());
    if (type == NotificationType.unknown) {
      AppDebuggingPrint.printDebug(
        '🧭 Unresolved notification type, opening notifications screen',
      );
      return null;
    }

    final destination = resolveNotificationDestination(
      type: type,
      videoId: data['videoId']?.toString() ?? '',
      playlistId: data['playlistId']?.toString() ?? '',
    );

    AppDebuggingPrint.printDebug(
      '🧭 Notification destination: '
      '${destination?.route ?? AppRoutes.notifications}',
    );

    return destination;
  }

  static Future<void> _markAsRead(Map<String, dynamic> data) async {
    final notificationId = data['notificationId']?.toString() ?? '';
    if (notificationId.isEmpty) return;

    try {
      await getIt<MarkNotificationReadUseCase>()(notificationId);
    } catch (e) {
      AppDebuggingPrint.printDebug(
        '❌ Failed to mark notification as read: $e',
      );
    }
  }
}
