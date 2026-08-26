import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String route, {Object? arguments}) {
    Navigator.of(this).pushNamed(route, arguments: arguments);
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

  void navigateBack() {
    Navigator.of(this).pop();
  }
}
