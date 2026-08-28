import 'package:flutter/material.dart';

/// Semantic color tokens for StreamPro, exposed as a [ThemeExtension] so
/// widgets can read them via `context.appTheme` (see
/// `lib/core/utils/extensions/get_app_theme.dart`).
///
/// Naming guide:
///   • brand      → [primaryColor], [secondaryColor] and their tints
///   • surfaces   → [backgroundColor], [surfaceColor]
///   • text       → [textPrimary], [textSecondary], [onPrimary]
///   • feedback   → [errorColor], [redNormalColor], [successColor],
///                  [warningColor], [liveColor], [starColor]
///   • neutrals   → grey200 … grey800 (cool slate scale)
///   • lines      → [boarderPrimary]
class AppTheme extends ThemeExtension<AppTheme> {
  // Brand
  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTint;
  final Color secondaryTint;

  // Surfaces
  final Color backgroundColor;
  final Color surfaceColor;
  final Color overlayColor;

  // Feedback / status
  final Color errorColor;
  final Color redNormalColor;
  final Color successColor;
  final Color warningColor;
  final Color liveColor;
  final Color starColor;

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

  // Legacy alias kept for backward compatibility: soft primary tint used
  // for chip/badge backgrounds. Same value as [primaryTint].
  final Color blueLight;

  final OutlineInputBorder outlineInputBorder;

  AppTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTint,
    required this.secondaryTint,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.overlayColor,
    required this.redNormalColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
    required this.liveColor,
    required this.starColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.onPrimary,
    required this.grey200,
    required this.grey500,
    required this.grey600,
    required this.grey700,
    required this.grey800,
    required this.boarderPrimary,
    required this.blueLight,
    required this.outlineInputBorder,
  });

  @override
  AppTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTint,
    Color? secondaryTint,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? overlayColor,
    Color? redNormalColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? liveColor,
    Color? starColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? onPrimary,
    Color? grey200,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
    Color? boarderPrimary,
    Color? blueLight,
    OutlineInputBorder? outlineInputBorder,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTint: primaryTint ?? this.primaryTint,
      secondaryTint: secondaryTint ?? this.secondaryTint,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      overlayColor: overlayColor ?? this.overlayColor,
      redNormalColor: redNormalColor ?? this.redNormalColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      liveColor: liveColor ?? this.liveColor,
      starColor: starColor ?? this.starColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      onPrimary: onPrimary ?? this.onPrimary,
      grey200: grey200 ?? this.grey200,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
      boarderPrimary: boarderPrimary ?? this.boarderPrimary,
      blueLight: blueLight ?? this.blueLight,
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
      secondaryTint: Color.lerp(secondaryTint, other.secondaryTint, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      redNormalColor: Color.lerp(redNormalColor, other.redNormalColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      liveColor: Color.lerp(liveColor, other.liveColor, t)!,
      starColor: Color.lerp(starColor, other.starColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
      grey500: Color.lerp(grey500, other.grey500, t)!,
      grey600: Color.lerp(grey600, other.grey600, t)!,
      grey700: Color.lerp(grey700, other.grey700, t)!,
      grey800: Color.lerp(grey800, other.grey800, t)!,
      boarderPrimary: Color.lerp(boarderPrimary, other.boarderPrimary, t)!,
      blueLight: Color.lerp(blueLight, other.blueLight, t)!,
      outlineInputBorder: outlineInputBorder,
    );
  }
}
