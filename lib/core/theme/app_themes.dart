import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/theme/app_theme.dart';
import 'package:stream_pro/core/theme/font_styles.dart';

/// Central theme factory for StreamPro.
///
/// Palette direction: a cinematic, streaming-first identity.
///   • Primary  — vivid "electric violet" (#6D28D9): energetic, modern,
///     and distinct from the generic blues used by most apps.
///   • Secondary — hot coral pink (#F43F5E): evokes "live" / play energy
///     and pairs with the primary for brand gradients.
///   • Neutrals — cool slate greys so video thumbnails stay the visual
///     focus, with a soft off-white canvas and pure-white surfaces.
class AppThemes {
  final AppTheme lightThemeColors = AppTheme(
    // Brand
    primaryColor: const Color(0xFF6D28D9), // electric violet
    secondaryColor: const Color(0xFFF43F5E), // hot coral pink
    primaryTint: const Color(0xFFEFEAFB), // soft violet wash for chips/badges
    secondaryTint: const Color(0xFFFEECEF), // soft coral wash

    // Surfaces
    backgroundColor: const Color(0xFFF7F7FB), // soft off-white canvas
    surfaceColor: Colors.white,
    overlayColor: const Color(0xB318181B), // scrim over thumbnails

    // Feedback / status
    redNormalColor: const Color(0xFFEF4444), // destructive actions
    errorColor: const Color(0xFFDC2626), // form & system errors
    successColor: const Color(0xFF16A34A), // success snack bars / states
    warningColor: const Color(0xFFF59E0B), // warnings
    liveColor: const Color(0xFFEF4444), // "LIVE" badges
    starColor: const Color(0xFFFBBF24), // ratings / favorites

    // Text
    textPrimary: const Color(0xFF18181B), // near-black slate
    textSecondary: const Color(0xFF52525B), // muted slate
    onPrimary: Colors.white, // text/icons on brand colors

    // Neutral scale (cool slate, light → dark)
    grey200: const Color(0xFFE4E4E7),
    grey500: const Color(0xFFD4D4D8),
    grey600: const Color(0xFFA1A1AA),
    grey700: const Color(0xFF71717A),
    grey800: const Color(0xFF3F3F46),

    // Lines
    boarderPrimary: const Color(0xFFE4E4EB),

    // Legacy alias — same soft violet wash as primaryTint.
    blueLight: const Color(0xFFEFEAFB),

    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFF71717A).withAlpha(90)),
    ),
  );

  ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: lightThemeColors.primaryColor,
      brightness: Brightness.light,
      primary: lightThemeColors.primaryColor,
      onPrimary: lightThemeColors.surfaceColor,
      secondary: lightThemeColors.secondaryColor,
      onSecondary: lightThemeColors.surfaceColor,
      surface: lightThemeColors.surfaceColor,
      onSurface: lightThemeColors.textPrimary,
      error: lightThemeColors.errorColor,
      onError: lightThemeColors.surfaceColor,
    );

    return ThemeData(
      useMaterial3: true, // Ensures modern component behaviors
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightThemeColors.backgroundColor,
      colorScheme: colorScheme,
      hintColor: lightThemeColors.grey600,
      dividerColor: lightThemeColors.boarderPrimary,
      cardColor: lightThemeColors.surfaceColor,
      primaryColor: lightThemeColors.primaryColor,

      // 1. Core Typography Mapping (Rubik, all 15 Material slots)
      fontFamily: FontStyles.fontFamily,
      textTheme: FontStyles.textTheme.apply(
        bodyColor: lightThemeColors.textPrimary,
        displayColor: lightThemeColors.textPrimary,
      ),

      // 2. Global AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: lightThemeColors.surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightThemeColors.textPrimary, size: 24),
        actionsIconTheme: IconThemeData(
          color: lightThemeColors.textSecondary,
          size: 24.sp,
        ),
        titleTextStyle: FontStyles.titleLarge.copyWith(
          color: lightThemeColors.textPrimary,
        ),
      ),

      // 3. Global Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightThemeColors.primaryColor,
          foregroundColor:
              lightThemeColors.surfaceColor, // Text/Icon color inside button
          disabledBackgroundColor: lightThemeColors.grey500,
          disabledForegroundColor: lightThemeColors.grey700,
          elevation: 0,
          textStyle: FontStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r), // Clean modern rounding
          ),
        ),
      ),

      // 4. Global Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightThemeColors.primaryColor,
          side: BorderSide(color: lightThemeColors.primaryColor, width: 1.5),
          textStyle: FontStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),

      // 5. Global Icon Theme (For standalone icons)
      iconTheme: IconThemeData(color: lightThemeColors.grey700, size: 24.sp),

      // 6. Form Fields & TextInputs (Crucial for a polished UX)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightThemeColors.surfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: FontStyles.bodyLarge.copyWith(
          color: lightThemeColors.textSecondary,
        ),
        floatingLabelStyle: FontStyles.labelMedium.copyWith(
          color: lightThemeColors.primaryColor,
        ),
        hintStyle: FontStyles.bodyLarge.copyWith(
          color: lightThemeColors.grey600,
        ),
        prefixIconColor: lightThemeColors.grey700,
        suffixIconColor: lightThemeColors.grey700,
        border: lightThemeColors.outlineInputBorder,
        enabledBorder: lightThemeColors.outlineInputBorder,
        focusedBorder: lightThemeColors.outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: lightThemeColors.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: lightThemeColors.outlineInputBorder.copyWith(
          borderSide: BorderSide(color: lightThemeColors.errorColor),
        ),
        focusedErrorBorder: lightThemeColors.outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: lightThemeColors.errorColor,
            width: 2,
          ),
        ),
        errorStyle: FontStyles.labelSmall.copyWith(
          color: lightThemeColors.errorColor,
        ),
      ),

      // 7. Card Theme
      cardTheme: CardThemeData(
        color: lightThemeColors.surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: lightThemeColors.boarderPrimary),
        ),
      ),

      // 8. Filter / choice chips (home feed filters)
      chipTheme: ChipThemeData(
        backgroundColor: lightThemeColors.surfaceColor,
        selectedColor: lightThemeColors.primaryColor,
        disabledColor: lightThemeColors.grey200,
        side: BorderSide(color: lightThemeColors.boarderPrimary),
        labelStyle: FontStyles.labelMedium.copyWith(
          color: lightThemeColors.textPrimary,
        ),
        secondaryLabelStyle: FontStyles.labelMedium.copyWith(
          color: lightThemeColors.surfaceColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),

      // 9. Progress indicators (loading states)
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: lightThemeColors.primaryColor,
        linearTrackColor: lightThemeColors.grey200,
        circularTrackColor: lightThemeColors.grey200,
      ),

      // 10. Snack bars
      snackBarTheme: SnackBarThemeData(
        backgroundColor: lightThemeColors.grey800,
        contentTextStyle: FontStyles.bodyMedium.copyWith(
          color: lightThemeColors.surfaceColor,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      // Keep your extensions injected at the bottom
      extensions: <ThemeExtension<dynamic>>[lightThemeColors],
    );
  }
}
