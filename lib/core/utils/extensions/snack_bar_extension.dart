import 'package:flutter/material.dart';
import 'package:stream_pro/core/theme/app_theme.dart';

extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar({required String message}) {
    ScaffoldMessenger.of(this).clearSnackBars();

    final appTheme = Theme.of(this).extension<AppTheme>();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: appTheme?.onPrimary)),
        backgroundColor: appTheme?.successColor,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  void showErrorSnackBar({required String message}) {
    ScaffoldMessenger.of(this).clearSnackBars();

    final appTheme = Theme.of(this).extension<AppTheme>();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: appTheme?.onPrimary)),
        backgroundColor: appTheme?.errorColor,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
