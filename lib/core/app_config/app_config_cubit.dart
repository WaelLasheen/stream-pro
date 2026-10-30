import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/services/storage/local_storage_service.dart';
import 'package:stream_pro/core/theme/app_themes.dart';
import 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  final LocalStorageService _storageService;

  static const String localeKey = 'app_locale';
  static const String themeKey = 'app_theme_type';

  AppConfigCubit(this._storageService)
    : super(
        const AppConfigState(
          locale: Locale('en'),
          currentTheme: AppThemeType.light,
        ),
      ) {
    _loadSavedConfig();
  }

  Future<void> _loadSavedConfig() async {
    final savedLang = await _storageService.readString(key: localeKey);
    final savedTheme = await _storageService.readString(key: themeKey);

    final locale = Locale(savedLang ?? 'en');
    final themeType = _parseThemeType(savedTheme);

    emit(state.copyWith(locale: locale, currentTheme: themeType));
  }

  Future<void> changeLanguage(String langCode) async {
    if (state.locale.languageCode == langCode) return;

    await _storageService.writeString(key: localeKey, value: langCode);
    emit(state.copyWith(locale: Locale(langCode)));
  }

  Future<void> changeTheme(AppThemeType themeType) async {
    if (state.currentTheme == themeType) return;

    await _storageService.writeString(key: themeKey, value: themeType.name);
    emit(state.copyWith(currentTheme: themeType));
  }

  AppThemeType _parseThemeType(String? themeStr) {
    return AppThemeType.values.firstWhere(
      (e) => e.name == themeStr,
      orElse: () => AppThemeType.light,
    );
  }
}
