import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/theme/app_theme.dart';
import 'package:stream_pro/core/theme/font_styles.dart';

enum AppThemeType { light, dark, modern, green, red }

class AppThemes {
  static ThemeData _buildThemeData({
    required AppTheme colors,
    required Brightness brightness,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: colors.primaryColor,
      brightness: brightness,
      primary: colors.primaryColor,
      onPrimary: colors.surfaceColor,
      secondary: colors.secondaryColor,
      onSecondary: colors.surfaceColor,
      surface: colors.surfaceColor,
      onSurface: colors.textPrimary,
      error: colors.errorColor,
      onError: colors.surfaceColor,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.backgroundColor,
      colorScheme: colorScheme,
      hintColor: colors.grey600,
      dividerColor: colors.boarderPrimary,
      cardColor: colors.surfaceColor,
      primaryColor: colors.primaryColor,
      fontFamily: FontStyles.fontFamily,
      textTheme: FontStyles.textTheme.apply(
        bodyColor: colors.textPrimary,
        displayColor: colors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.textPrimary, size: 24),
        actionsIconTheme: IconThemeData(
          color: colors.textSecondary,
          size: 24.sp,
        ),
        titleTextStyle: FontStyles.titleLarge.copyWith(
          color: colors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primaryColor,
          foregroundColor: colors.surfaceColor,
          disabledBackgroundColor: colors.grey500,
          disabledForegroundColor: colors.grey700,
          elevation: 0,
          textStyle: FontStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primaryColor,
          side: BorderSide(color: colors.primaryColor, width: 1.5),
          textStyle: FontStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      iconTheme: IconThemeData(color: colors.grey700, size: 24.sp),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: FontStyles.bodyLarge.copyWith(color: colors.textSecondary),
        floatingLabelStyle: FontStyles.labelMedium.copyWith(
          color: colors.primaryColor,
        ),
        hintStyle: FontStyles.bodyLarge.copyWith(color: colors.grey600),
        prefixIconColor: colors.grey700,
        suffixIconColor: colors.grey700,
        border: colors.outlineInputBorder,
        enabledBorder: colors.outlineInputBorder,
        focusedBorder: colors.outlineInputBorder.copyWith(
          borderSide: BorderSide(color: colors.primaryColor, width: 2),
        ),
        errorBorder: colors.outlineInputBorder.copyWith(
          borderSide: BorderSide(color: colors.errorColor),
        ),
        focusedErrorBorder: colors.outlineInputBorder.copyWith(
          borderSide: BorderSide(color: colors.errorColor, width: 2),
        ),
        errorStyle: FontStyles.labelSmall.copyWith(color: colors.errorColor),
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: colors.boarderPrimary),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceColor,
        selectedColor: colors.primaryColor,
        disabledColor: colors.grey200,
        side: BorderSide(color: colors.boarderPrimary),
        labelStyle: FontStyles.labelMedium.copyWith(color: colors.textPrimary),
        secondaryLabelStyle: FontStyles.labelMedium.copyWith(
          color: colors.surfaceColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primaryColor,
        linearTrackColor: colors.grey200,
        circularTrackColor: colors.grey200,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.grey800,
        contentTextStyle: FontStyles.bodyMedium.copyWith(
          color: colors.surfaceColor,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[colors],
    );
  }

  /// Factory method to return the correct ThemeData based on user selection
  static ThemeData getTheme(AppThemeType themeType) {
    switch (themeType) {
      case AppThemeType.light:
        return _buildThemeData(
          colors: _lightColors,
          brightness: Brightness.light,
        );
      case AppThemeType.dark:
        return _buildThemeData(
          colors: _darkColors,
          brightness: Brightness.dark,
        );
      case AppThemeType.modern:
        return _buildThemeData(
          colors: _modernColors,
          brightness: Brightness.dark,
        );
      case AppThemeType.green:
        return _buildThemeData(
          colors: _greenColors,
          brightness: Brightness.light,
        );
      case AppThemeType.red:
        return _buildThemeData(colors: _redColors, brightness: Brightness.dark);
    }
  }

  // --- THEME EXTENSIONS (COLORS) ---

  static AppTheme get _lightColors => AppTheme(
    primaryColor: const Color(0xFF6D28D9),
    secondaryColor: const Color(0xFFF43F5E),
    primaryTint: const Color(0xFFEFEAFB),
    surfaceDark: const Color(0xFF2A2A2A),
    borderLight: const Color(0xFFE2E8F0),
    accentPurple: const Color(0xFF6C5CE7),
    blueAccent: const Color(0xFF2196F3),
    tealAccent: const Color(0xFF1DE9B6),
    purpleTint: const Color(0xFF8B5CF6),
    pinkAccent: const Color(0xFFEC4899),
    canvasLight: const Color(0xFFF5F7FA),
    dividerMuted: const Color(0xFFD9DEE5),
    errorColorShade400: const Color(0xFFEF5350),
    textSecondaryShade500: const Color(0xFF9E9E9E),
    backgroundColor: const Color(0xFFF7F7FB),
    surfaceColor: Colors.white,
    overlayColor: const Color(0xB318181B),
    redNormalColor: const Color(0xFFEF4444),
    errorColor: const Color(0xFFDC2626),
    successColor: const Color(0xFF16A34A),
    warningColor: const Color(0xFFF59E0B),
    textPrimary: const Color(0xFF18181B),
    textSecondary: const Color(0xFF52525B),
    onPrimary: Colors.white,
    grey200: const Color(0xFFE4E4E7),
    grey500: const Color(0xFFD4D4D8),
    grey600: const Color(0xFFA1A1AA),
    grey700: const Color(0xFF71717A),
    grey800: const Color(0xFF3F3F46),
    boarderPrimary: const Color(0xFFE4E4EB),
    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFF71717A).withAlpha(90)),
    ),
  );

  static AppTheme get _darkColors => AppTheme(
    primaryColor: const Color(0xFF8B5CF6),
    secondaryColor: const Color(0xFFFB7185),
    primaryTint: const Color(0xFF2E1065),
    surfaceDark: const Color(0xFF000000),
    borderLight: const Color(0xFF334155),
    accentPurple: const Color(0xFFA78BFA),
    blueAccent: const Color(0xFF60A5FA),
    tealAccent: const Color(0xFF2DD4BF),
    purpleTint: const Color(0xFFC4B5FD),
    pinkAccent: const Color(0xFFF472B6),
    canvasLight: const Color(0xFF1E293B),
    dividerMuted: const Color(0xFF475569),
    errorColorShade400: const Color(0xFFF87171),
    textSecondaryShade500: const Color(0xFF94A3B8),
    backgroundColor: const Color(0xFF0F0F12),
    surfaceColor: const Color(0xFF18181B),
    overlayColor: const Color(0xB3000000),
    redNormalColor: const Color(0xFFF87171),
    errorColor: const Color(0xFFF87171),
    successColor: const Color(0xFF4ADE80),
    warningColor: const Color(0xFFFBBF24),
    textPrimary: const Color(0xFFF8FAFC),
    textSecondary: const Color(0xFFCBD5E1),
    onPrimary: Colors.white,
    grey200: const Color(0xFF334155),
    grey500: const Color(0xFF475569),
    grey600: const Color(0xFF64748B),
    grey700: const Color(0xFF94A3B8),
    grey800: const Color(0xFFCBD5E1),
    boarderPrimary: const Color(0xFF27272A),
    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFF64748B).withAlpha(90)),
    ),
  );

  static AppTheme get _modernColors => AppTheme(
    primaryColor: const Color(0xFF06B6D4),
    secondaryColor: const Color(0xFFD946EF), // Cyan & Fuchsia
    primaryTint: const Color(0xFF164E63),
    surfaceDark: const Color(0xFF020617),
    borderLight: const Color(0xFF1E293B),
    accentPurple: const Color(0xFF38BDF8),
    blueAccent: const Color(0xFF0EA5E9),
    tealAccent: const Color(0xFF14B8A6),
    purpleTint: const Color(0xFFE879F9),
    pinkAccent: const Color(0xFFF472B6),
    canvasLight: const Color(0xFF0F172A),
    dividerMuted: const Color(0xFF334155),
    errorColorShade400: const Color(0xFFFB7185),
    textSecondaryShade500: const Color(0xFF94A3B8),
    backgroundColor: const Color(0xFF020617),
    surfaceColor: const Color(0xFF0F172A),
    overlayColor: const Color(0xB3000000),
    redNormalColor: const Color(0xFFF43F5E),
    errorColor: const Color(0xFFF43F5E),
    successColor: const Color(0xFF10B981),
    warningColor: const Color(0xFFF59E0B),
    textPrimary: const Color(0xFFF8FAFC),
    textSecondary: const Color(0xFFCBD5E1),
    onPrimary: Colors.white,
    grey200: const Color(0xFF1E293B),
    grey500: const Color(0xFF334155),
    grey600: const Color(0xFF475569),
    grey700: const Color(0xFF64748B),
    grey800: const Color(0xFF94A3B8),
    boarderPrimary: const Color(0xFF1E293B),
    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFF06B6D4).withAlpha(90)),
    ),
  );

  static AppTheme get _greenColors => AppTheme(
    primaryColor: const Color(0xFF10B981),
    secondaryColor: const Color(0xFF059669), // Emerald
    primaryTint: const Color(0xFFD1FAE5),
    surfaceDark: const Color(0xFF064E3B),
    borderLight: const Color(0xFFA7F3D0),
    accentPurple: const Color(0xFF34D399),
    blueAccent: const Color(0xFF0284C7),
    tealAccent: const Color(0xFF0D9488),
    purpleTint: const Color(0xFF6EE7B7),
    pinkAccent: const Color(0xFFFB7185),
    canvasLight: const Color(0xFFF0FDF4),
    dividerMuted: const Color(0xFF6EE7B7),
    errorColorShade400: const Color(0xFFF87171),
    textSecondaryShade500: const Color(0xFF6B7280),
    backgroundColor: const Color(0xFFF0FDF4),
    surfaceColor: Colors.white,
    overlayColor: const Color(0xB3064E3B),
    redNormalColor: const Color(0xFFEF4444),
    errorColor: const Color(0xFFDC2626),
    successColor: const Color(0xFF16A34A),
    warningColor: const Color(0xFFF59E0B),
    textPrimary: const Color(0xFF064E3B),
    textSecondary: const Color(0xFF047857),
    onPrimary: Colors.white,
    grey200: const Color(0xFFD1FAE5),
    grey500: const Color(0xFFA7F3D0),
    grey600: const Color(0xFF6EE7B7),
    grey700: const Color(0xFF34D399),
    grey800: const Color(0xFF10B981),
    boarderPrimary: const Color(0xFFA7F3D0),
    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFF10B981).withAlpha(90)),
    ),
  );

  static AppTheme get _redColors => AppTheme(
    primaryColor: const Color(0xFFE11D48),
    secondaryColor: const Color(0xFFBE123C), // Crimson
    primaryTint: const Color(0xFF4C0519),
    surfaceDark: const Color(0xFF000000),
    borderLight: const Color(0xFF4C0519),
    accentPurple: const Color(0xFFFB7185),
    blueAccent: const Color(0xFF3B82F6),
    tealAccent: const Color(0xFF14B8A6),
    purpleTint: const Color(0xFFFDA4AF),
    pinkAccent: const Color(0xFFF43F5E),
    canvasLight: const Color(0xFF1C1917),
    dividerMuted: const Color(0xFF44403C),
    errorColorShade400: const Color(0xFFF87171),
    textSecondaryShade500: const Color(0xFFA8A29E),
    backgroundColor: const Color(0xFF1C1917),
    surfaceColor: const Color(0xFF292524),
    overlayColor: const Color(0xB3000000),
    redNormalColor: const Color(0xFFEF4444),
    errorColor: const Color(0xFFF87171),
    successColor: const Color(0xFF22C55E),
    warningColor: const Color(0xFFF59E0B),
    textPrimary: const Color(0xFFFFFBEB),
    textSecondary: const Color(0xFFD6D3D1),
    onPrimary: Colors.white,
    grey200: const Color(0xFF44403C),
    grey500: const Color(0xFF57534E),
    grey600: const Color(0xFF78716C),
    grey700: const Color(0xFFA8A29E),
    grey800: const Color(0xFFD6D3D1),
    boarderPrimary: const Color(0xFF44403C),
    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFFE11D48).withAlpha(90)),
    ),
  );
}
