import 'package:flutter/material.dart';

/// Semantic color tokens for StreamPro, exposed as a [ThemeExtension] so
/// widgets can read them via `context.appTheme` (see
/// `lib/core/utils/extensions/get_app_theme.dart`).
class AppTheme extends ThemeExtension<AppTheme> {
  // Brand
  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTint;

  // New Extracted Colors
  final Color surfaceDark;
  final Color borderLight;
  final Color accentPurple;
  final Color blueAccent;
  final Color tealAccent;
  final Color purpleTint;
  final Color pinkAccent;
  final Color canvasLight;
  final Color dividerMuted;

  // Specific Shaded/Tinted Tokens requested
  final Color errorColorShade400;
  final Color textSecondaryShade500;

  // Surfaces
  final Color backgroundColor;
  final Color surfaceColor;
  final Color overlayColor;

  // Feedback / status
  final Color errorColor;
  final Color redNormalColor;
  final Color successColor;
  final Color warningColor;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color onPrimary;

  // Neutral scale (light → dark)
  final Color grey200;
  final Color grey500;
  final Color grey600;
  final Color grey700;
  final Color grey800;

  // Lines
  final Color boarderPrimary;

  final OutlineInputBorder outlineInputBorder;

  AppTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTint,
    required this.surfaceDark,
    required this.borderLight,
    required this.accentPurple,
    required this.blueAccent,
    required this.tealAccent,
    required this.purpleTint,
    required this.pinkAccent,
    required this.canvasLight,
    required this.dividerMuted,
    required this.errorColorShade400,
    required this.textSecondaryShade500,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.overlayColor,
    required this.redNormalColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.onPrimary,
    required this.grey200,
    required this.grey500,
    required this.grey600,
    required this.grey700,
    required this.grey800,
    required this.boarderPrimary,
    required this.outlineInputBorder,
  });

  @override
  AppTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTint,
    Color? surfaceDark,
    Color? borderLight,
    Color? accentPurple,
    Color? blueAccent,
    Color? tealAccent,
    Color? purpleTint,
    Color? pinkAccent,
    Color? canvasLight,
    Color? dividerMuted,
    Color? errorColorShade400,
    Color? textSecondaryShade500,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? overlayColor,
    Color? redNormalColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? onPrimary,
    Color? grey200,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
    Color? boarderPrimary,
    OutlineInputBorder? outlineInputBorder,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTint: primaryTint ?? this.primaryTint,
      surfaceDark: surfaceDark ?? this.surfaceDark,
      borderLight: borderLight ?? this.borderLight,
      accentPurple: accentPurple ?? this.accentPurple,
      blueAccent: blueAccent ?? this.blueAccent,
      tealAccent: tealAccent ?? this.tealAccent,
      purpleTint: purpleTint ?? this.purpleTint,
      pinkAccent: pinkAccent ?? this.pinkAccent,
      canvasLight: canvasLight ?? this.canvasLight,
      dividerMuted: dividerMuted ?? this.dividerMuted,
      errorColorShade400: errorColorShade400 ?? this.errorColorShade400,
      textSecondaryShade500:
          textSecondaryShade500 ?? this.textSecondaryShade500,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      overlayColor: overlayColor ?? this.overlayColor,
      redNormalColor: redNormalColor ?? this.redNormalColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      onPrimary: onPrimary ?? this.onPrimary,
      grey200: grey200 ?? this.grey200,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
      boarderPrimary: boarderPrimary ?? this.boarderPrimary,
      outlineInputBorder: outlineInputBorder ?? this.outlineInputBorder,
    );
  }

  @override
  AppTheme lerp(covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }

    return AppTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      primaryTint: Color.lerp(primaryTint, other.primaryTint, t)!,
      surfaceDark: Color.lerp(surfaceDark, other.surfaceDark, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      accentPurple: Color.lerp(accentPurple, other.accentPurple, t)!,
      blueAccent: Color.lerp(blueAccent, other.blueAccent, t)!,
      tealAccent: Color.lerp(tealAccent, other.tealAccent, t)!,
      purpleTint: Color.lerp(purpleTint, other.purpleTint, t)!,
      pinkAccent: Color.lerp(pinkAccent, other.pinkAccent, t)!,
      canvasLight: Color.lerp(canvasLight, other.canvasLight, t)!,
      dividerMuted: Color.lerp(dividerMuted, other.dividerMuted, t)!,
      errorColorShade400: Color.lerp(
        errorColorShade400,
        other.errorColorShade400,
        t,
      )!,
      textSecondaryShade500: Color.lerp(
        textSecondaryShade500,
        other.textSecondaryShade500,
        t,
      )!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      redNormalColor: Color.lerp(redNormalColor, other.redNormalColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
      grey500: Color.lerp(grey500, other.grey500, t)!,
      grey600: Color.lerp(grey600, other.grey600, t)!,
      grey700: Color.lerp(grey700, other.grey700, t)!,
      grey800: Color.lerp(grey800, other.grey800, t)!,
      boarderPrimary: Color.lerp(boarderPrimary, other.boarderPrimary, t)!,
      outlineInputBorder: outlineInputBorder,
    );
  }
}
