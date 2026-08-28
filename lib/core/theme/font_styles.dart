import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Typography scale for StreamPro.
///
/// Font family: Rubik — a rounded, geometric sans-serif that fits the
/// modern, media-rich nature of a streaming app. The static weights
/// (Regular 400 / Medium 500 / SemiBold 600 / Bold 700) are bundled in
/// `fonts/` and declared in `pubspec.yaml`.
///
/// Every getter below maps 1:1 to a Material 3 [TextTheme] slot:
///
/// | Getter          | TextTheme slot | Size  | Weight | Usage                              |
/// |-----------------|----------------|-------|--------|------------------------------------|
/// | displayLarge    | displayLarge   | 57.sp | w700   | Hero / onboarding splash numbers   |
/// | displayMedium   | displayMedium  | 45.sp | w700   | Large hero headings                |
/// | displaySmall    | displaySmall   | 36.sp | w600   | Prominent hero sub-headings        |
/// | headlineLarge   | headlineLarge  | 32.sp | w700   | Main page headings                 |
/// | headlineMedium  | headlineMedium | 28.sp | w600   | Screen titles (auth, details)      |
/// | headlineSmall   | headlineSmall  | 24.sp | w600   | Section / video titles             |
/// | titleLarge      | titleLarge     | 22.sp | w600   | App bar titles, dialog titles      |
/// | titleMedium     | titleMedium    | 16.sp | w600   | Card titles, list headers          |
/// | titleSmall      | titleSmall     | 14.sp | w600   | Sub-titles, chip labels            |
/// | bodyLarge       | bodyLarge      | 16.sp | w400   | Long-form paragraphs, inputs       |
/// | bodyMedium      | bodyMedium     | 14.sp | w400   | Default body copy                  |
/// | bodySmall       | bodySmall      | 12.sp | w400   | Secondary details, meta lines      |
/// | labelLarge      | labelLarge     | 14.sp | w600   | Buttons, tabs                      |
/// | labelMedium     | labelMedium    | 12.sp | w500   | Badges, form labels                |
/// | labelSmall      | labelSmall     | 11.sp | w500   | Captions, timestamps, view counts  |
///
/// Colors are intentionally NOT set here — they are applied from the
/// [AppTheme] extension / [ColorScheme] where the style is used.
abstract class FontStyles {
  static const String fontFamily = 'Rubik';

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    double letterSpacing = 0,
    double height = 1.3,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // ── Display ────────────────────────────────────────────────────────────

  /// Material: displayLarge — extremely large hero text.
  static TextStyle get displayLarge => _base(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.12,
  );

  /// Material: displayMedium.
  static TextStyle get displayMedium => _base(
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.15,
  );

  /// Material: displaySmall.
  static TextStyle get displaySmall => _base(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.22,
  );

  // ── Headline ───────────────────────────────────────────────────────────

  /// Material: headlineLarge — main page headings.
  static TextStyle get headlineLarge => _base(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.25,
  );

  /// Material: headlineMedium — screen titles (auth headers, etc.).
  static TextStyle get headlineMedium => _base(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.28,
  );

  /// Material: headlineSmall — section / video detail titles.
  static TextStyle get headlineSmall => _base(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
  );

  // ── Title ──────────────────────────────────────────────────────────────

  /// Material: titleLarge — app bar titles, dialog titles.
  static TextStyle get titleLarge => _base(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.27,
  );

  /// Material: titleMedium — card titles, list headers.
  static TextStyle get titleMedium => _base(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Material: titleSmall — sub-titles, chip labels.
  static TextStyle get titleSmall => _base(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ── Body ───────────────────────────────────────────────────────────────

  /// Material: bodyLarge — paragraphs and text inputs.
  static TextStyle get bodyLarge => _base(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  /// Material: bodyMedium — default body copy.
  static TextStyle get bodyMedium => _base(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  /// Material: bodySmall — secondary details and meta lines.
  static TextStyle get bodySmall => _base(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ── Label ──────────────────────────────────────────────────────────────

  /// Material: labelLarge — buttons and tabs.
  static TextStyle get labelLarge => _base(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// Material: labelMedium — badges and form labels.
  static TextStyle get labelMedium => _base(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  /// Material: labelSmall — captions, timestamps, view counts.
  static TextStyle get labelSmall => _base(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );

  /// Convenience: the full Material 3 text theme built from the styles
  /// above. Injected into [ThemeData.textTheme] in `app_themes.dart`.
  static TextTheme get textTheme => TextTheme(
    displayLarge: FontStyles.displayLarge,
    displayMedium: FontStyles.displayMedium,
    displaySmall: FontStyles.displaySmall,
    headlineLarge: FontStyles.headlineLarge,
    headlineMedium: FontStyles.headlineMedium,
    headlineSmall: FontStyles.headlineSmall,
    titleLarge: FontStyles.titleLarge,
    titleMedium: FontStyles.titleMedium,
    titleSmall: FontStyles.titleSmall,
    bodyLarge: FontStyles.bodyLarge,
    bodyMedium: FontStyles.bodyMedium,
    bodySmall: FontStyles.bodySmall,
    labelLarge: FontStyles.labelLarge,
    labelMedium: FontStyles.labelMedium,
    labelSmall: FontStyles.labelSmall,
  );
}
