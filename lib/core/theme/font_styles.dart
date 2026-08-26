import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Type scale pulled directly from the "Marketing SAAS" Figma file's
/// exported text styles (fontFamily: Rubik, letterSpacing: 0% everywhere).
///
/// Figma scale reference (px):
///   heading3xl 52 | heading2xl 46 | headingXl 41 | headingLg 36
///   headingMd  32 | headingSm  29 | headingXs   26
///   text3xl    23 | text2xl    20 | textXl      18
///   textLg     16 | textMd     14 | textSm      13 | textXs 11
///
/// Each of the styles below is mapped to the closest matching Figma
/// text style (name shown in the comment above each getter).
abstract class FontStyles {
  static const String fontFamily = 'Rubik';

  // Figma: heading3xl/Bold (52) -- kept for large hero/display text if needed.
  static TextStyle get display => TextStyle(
    fontFamily: fontFamily,
    fontSize: 52.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  // Figma: headingMd/Bold (32) — exact size match.
  static TextStyle get h1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
  );

  // Figma: text3xl/Bold (23) — closest match to the previous 24sp h2.
  static TextStyle get h2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  // Figma: text2xl/Semibold (20) — exact size match.
  static TextStyle get h3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // Figma: textLg/Regular (16) — exact size match.
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );

  // Figma: textMd/Regular (14) — exact size match.
  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );

  // Figma: textSm/Regular (13) — closest match to the previous 12sp bodySmall.
  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );

  // Figma: textLg/Semibold (16) — exact size match.
  static TextStyle get button => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // Figma: textMd/Medium (14) — exact size match.
  // NOTE: color intentionally left out here — set it via textSecondary
  // from the AppTheme extension where the widget is used, rather than
  // hardcoding Colors.grey.
  static TextStyle get label => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  // Figma: textXs/Regular (11) — useful for captions/helper text.
  static TextStyle get caption => TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );
}