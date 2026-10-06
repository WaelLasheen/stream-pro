import 'package:stream_pro/generated/l10n.dart';

/// Centralized form validation rules for the auth screens.
///
/// All messages come from the localization file so they stay
/// consistent with the rest of the app (Arabic / English).
abstract class AuthValidators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.current.fullNameReq;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.current.emailReq;
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return S.current.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.passwordReq;
    }
    if (value.length < 8) {
      return S.current.invalidPassword;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return S.current.confirmPasswordReq;
    }
    if (value != password) {
      return S.current.confirmPasswordMismatch;
    }
    return null;
  }
}
