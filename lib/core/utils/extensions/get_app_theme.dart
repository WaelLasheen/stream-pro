import 'package:flutter/material.dart';
import 'package:stream_pro/core/theme/app_theme.dart';

extension GetAppTheme on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get globalTheme => Theme.of(this);
}
