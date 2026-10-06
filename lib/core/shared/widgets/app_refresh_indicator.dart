import 'package:flutter/material.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class AppRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: appTheme.primaryColor,
      backgroundColor: appTheme.surfaceColor,
      child: child,
    );
  }
}
