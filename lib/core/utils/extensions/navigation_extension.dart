import 'package:flutter/material.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/routing/observers/app_route_observer.dart';

extension NavigationExtension on BuildContext {
  Future<T?> navigateTo<T extends Object?>(
    String route, {
    Object? arguments,
  }) async {
    final result = await Navigator.of(
      this,
    ).pushNamed(route, arguments: arguments);
    return result as T?;
  }

  void navigateToAndReplace(String route, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(route, arguments: arguments);
  }

  void navigateToAndClearStack(String route, {Object? arguments}) {
    Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(route, (route) => false, arguments: arguments);
  }

  void navigateToAndClearUntil(String route, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      route,
      (currentRoute) => currentRoute.settings.name == route,
      arguments: arguments,
    );
  }

  void navigateBack<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}

extension SmartChannelNavigation on BuildContext {
  void navigateToChannelDetails(String channelId) {
    final navigator = navigatorKey.currentState;

    // Fallback if navigator isn't ready
    if (navigator == null) {
      navigateTo(AppRoutes.channelDetails, arguments: channelId);
      return;
    }

    // 1. Prevent pushing the same channel if we are ALREADY on it
    final currentRoute = ModalRoute.of(this)?.settings;
    if (currentRoute?.name == AppRoutes.channelDetails &&
        currentRoute?.arguments == channelId) {
      return; // Already here, do nothing
    }

    // 2. Safely search the active stack for this channel (most recent first)
    Route<dynamic>? targetRoute;
    for (int i = routeHistoryObserver.history.length - 1; i >= 0; i--) {
      final route = routeHistoryObserver.history[i];
      if (route.settings.name == AppRoutes.channelDetails &&
          route.settings.arguments == channelId) {
        targetRoute = route;
        break;
      }
    }

    // 3. If found, pop back to it (keeps the stack below it perfectly intact!)
    if (targetRoute != null) {
      navigator.popUntil((route) => route == targetRoute);
    }
    // 4. If NOT found, push normally (keeps the entire current stack intact!)
    else {
      navigateTo(AppRoutes.channelDetails, arguments: channelId);
    }
  }
}
