import 'package:flutter/material.dart';
import 'package:stream_pro/core/theme/app_theme.dart';

extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar({required String message}) {
    final appTheme = Theme.of(this).extension<AppTheme>();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: appTheme?.onPrimary ?? Colors.white),
        ),
        backgroundColor: appTheme?.successColor ?? Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showErrorSnackBar({required String message}) {
    final appTheme = Theme.of(this).extension<AppTheme>();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: appTheme?.onPrimary ?? Colors.white),
        ),
        backgroundColor: appTheme?.errorColor ?? Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
