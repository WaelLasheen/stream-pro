import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_pro/core/error/exceptions/google_auth_exception.dart';
import 'package:stream_pro/core/services/google_auth/google_auth_service.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';
import 'package:stream_pro/generated/l10n.dart';

class GoogleAuthServiceImpl implements GoogleAuthService {
  static const String _serverClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );

  Future<void>? _initialization;

  @override
  Future<String> getIdToken() async {
    try {
      await _ensureInitialized();

      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        AppDebuggingPrint.printDebug(
          'Google sign-in is not supported on this platform',
        );
        throw GoogleAuthException(S.current.googleSignInConfigError);
      }

      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;

      if (idToken == null || idToken.isEmpty) {
        AppDebuggingPrint.printDebug(
          'Google sign-in returned an empty ID token. '
          'Check GOOGLE_SERVER_CLIENT_ID and the OAuth client configuration.',
        );
        throw GoogleAuthException(S.current.googleSignInConfigError);
      }

      return idToken;
    } on GoogleSignInException catch (error) {
      AppDebuggingPrint.printDebug(
        'Google sign-in failed: code=${error.code.name}, '
        'description=${error.description}, details=${error.details}',
      );

      switch (error.code) {
        case GoogleSignInExceptionCode.canceled:
        case GoogleSignInExceptionCode.interrupted:
          throw const GoogleAuthException.cancelled();
        case GoogleSignInExceptionCode.clientConfigurationError:
        case GoogleSignInExceptionCode.providerConfigurationError:
          throw GoogleAuthException(S.current.googleSignInConfigError);
        default:
          throw GoogleAuthException(S.current.googleSignInError);
      }
    } on GoogleAuthException {
      rethrow;
    } catch (error, stackTrace) {
      AppDebuggingPrint.printDebug(
        'Google sign-in failed: $error\n$stackTrace',
      );
      throw GoogleAuthException(S.current.googleSignInError);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _ensureInitialized();
      await GoogleSignIn.instance.signOut();
    } on GoogleAuthException {
      rethrow;
    } catch (error, stackTrace) {
      AppDebuggingPrint.printDebug(
        'Google sign-out failed: $error\n$stackTrace',
      );
      throw GoogleAuthException(S.current.googleSignInError);
    }
  }

  Future<void> _ensureInitialized() async {
    _initialization ??= _initialize();

    try {
      await _initialization;
    } catch (_) {
      _initialization = null;
      rethrow;
    }
  }

  Future<void> _initialize() {
    return GoogleSignIn.instance.initialize(
      serverClientId: _serverClientId.isEmpty ? null : _serverClientId,
    );
  }
}
