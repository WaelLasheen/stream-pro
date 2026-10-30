import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_pro/core/theme/app_themes.dart';

class AppConfigState extends Equatable {
  final Locale locale;
  final AppThemeType currentTheme;

  const AppConfigState({
    required this.locale,
    this.currentTheme = AppThemeType.light,
  });

  AppConfigState copyWith({Locale? locale, AppThemeType? currentTheme}) {
    return AppConfigState(
      locale: locale ?? this.locale,
      currentTheme: currentTheme ?? this.currentTheme,
    );
  }

  @override
  List<Object?> get props => [locale, currentTheme];
}
