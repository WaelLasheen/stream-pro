import 'package:flutter/material.dart';

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
