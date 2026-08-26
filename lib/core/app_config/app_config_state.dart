import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppConfigState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;

  const AppConfigState({required this.locale, required this.themeMode});

  AppConfigState copyWith({Locale? locale, ThemeMode? themeMode}) {
    return AppConfigState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [locale, themeMode];
}
