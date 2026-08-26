import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/theme/app_theme.dart';
import 'package:stream_pro/core/theme/font_styles.dart';

class AppThemes {
  final AppTheme lightThemeColors = AppTheme(
    primaryColor: const Color(0xFF4F46E5), // done
    secondaryColor: const Color(0xFFF56E14),
    backgroundColor: const Color(0xFFF5F5F5),
    surfaceColor: Colors.white,
    redNormalColor: const Color(0xFFEA0606), // done
    errorColor: const Color(0xFFB00505), // done
    textPrimary: const Color(0xFF121212), // done
    textSecondary: const Color(0xFF636262),
    grey200: const Color(0xFFE8E8E8),
    grey500: const Color(0xFFDEDEDE),
    grey600: const Color(0xFFCACACA),
    grey700: const Color(0xFF9E9E9E),
    grey800: const Color(0xFF7A7A7A),
    boarderPrimary: const Color(0xFFE9E9E9),
    blueLight: const Color(0xFFEDEDFC),
    outlineInputBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: const Color(0xFF757575).withAlpha(100)),
    ),
  );

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Ensures modern component behaviors
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightThemeColors.backgroundColor,

      // 1. Core Typography Mapping
      fontFamily: FontStyles.fontFamily,
      textTheme: TextTheme(
        // Display - extremely large text
        displayLarge: FontStyles.display,

        // Headlines - main page headings
        headlineLarge: FontStyles.h1,
        headlineMedium: FontStyles.h2,
        headlineSmall: FontStyles.h3,

        // Titles - secondary headings, app bar titles, form headers
        titleLarge: FontStyles.h3,
        titleMedium: FontStyles.button,
        titleSmall: FontStyles.label,

        // Body - body paragraphs and details
        bodyLarge: FontStyles.bodyLarge,
        bodyMedium: FontStyles.bodyMedium,
        bodySmall: FontStyles.bodySmall,

        // Labels - captions, buttons, metadata
        labelLarge: FontStyles.button,
        labelMedium: FontStyles.label,
        labelSmall: FontStyles.caption,
      ),

      // 2. Global AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: lightThemeColors.surfaceColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightThemeColors.textPrimary, size: 24),
        actionsIconTheme: IconThemeData(
          color: lightThemeColors.textSecondary,
          size: 24.sp,
        ),
        titleTextStyle: FontStyles.h3.copyWith(
          color: lightThemeColors.textPrimary,
        ),
      ),

      // 3. Global Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightThemeColors.primaryColor,
          foregroundColor:
              lightThemeColors.surfaceColor, // Text/Icon color inside button
          disabledBackgroundColor: lightThemeColors.textSecondary.withAlpha(50),
          disabledForegroundColor: lightThemeColors.textSecondary,
          elevation: 0,
          textStyle: FontStyles.button,
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
          textStyle: FontStyles.button,
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
        labelStyle: FontStyles.bodyMedium.copyWith(
          color: lightThemeColors.textPrimary,
        ),
        hintStyle: FontStyles.bodyMedium.copyWith(
          color: lightThemeColors.textSecondary,
        ),
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
      ),

      // 7. Card Theme
      cardTheme: CardThemeData(
        color: lightThemeColors.surfaceColor,
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),

      // Keep your extensions injected at the bottom
      extensions: <ThemeExtension<dynamic>>[lightThemeColors],
    );
  }
}
