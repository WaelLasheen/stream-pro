import 'package:stream_pro/core/storage/secure_storage_service.dart';

class TokenStorageService {
  final SecureStorageService _secureStorage;

  static const String _kAccessToken = 'access_token';

  TokenStorageService(this._secureStorage);

  Future<void> saveAccessToken(String token) =>
      _secureStorage.write(key: _kAccessToken, value: token);

  Future<String?> getAccessToken() => _secureStorage.read(key: _kAccessToken);

  Future<void> clearToken() => _secureStorage.delete(key: _kAccessToken);
}
