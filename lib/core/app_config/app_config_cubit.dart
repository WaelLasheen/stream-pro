import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/storage/local_storage_service.dart';
import 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  final LocalStorageService _storageService;

  static const String _localeKey = 'app_locale';
  static const String _themeKey = 'app_theme_mode';

  AppConfigCubit(this._storageService)
    : super(
        const AppConfigState(locale: Locale('en'), themeMode: ThemeMode.light),
      ) {
    _loadSavedConfig();
  }

  Future<void> _loadSavedConfig() async {
    final savedLang = await _storageService.readString(key: _localeKey);
    final savedTheme = await _storageService.readString(key: _themeKey);

    final locale = Locale(savedLang ?? 'en');
    final themeMode = _parseThemeMode(savedTheme);

    emit(state.copyWith(locale: locale, themeMode: themeMode));
  }

  Future<void> changeLanguage(String langCode) async {
    if (state.locale.languageCode == langCode) return;

    await _storageService.writeString(key: _localeKey, value: langCode);
    emit(state.copyWith(locale: Locale(langCode)));
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    if (state.themeMode == themeMode) return;

    await _storageService.writeString(key: _themeKey, value: themeMode.name);
    emit(state.copyWith(themeMode: themeMode));
  }

  ThemeMode _parseThemeMode(String? themeStr) {
    switch (themeStr) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light;
    }
  }
}
