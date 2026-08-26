import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_pro/core/error/exceptions/cache_exception.dart';
import 'secure_storage_service.dart';

class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage;
  SecureStorageServiceImpl(this._storage);

  Future<T> _exceptionGuard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw CacheException(
        'Failed to execute local storage operation, ${e.toString()}',
      );
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _exceptionGuard(() => _storage.write(key: key, value: value));
  }

  @override
  Future<String?> read({required String key}) async {
    return await _exceptionGuard(() => _storage.read(key: key));
  }

  @override
  Future<void> delete({required String key}) async {
    await _exceptionGuard(() => _storage.delete(key: key));
  }

  @override
  Future<void> clearAll() async {
    await _exceptionGuard(() => _storage.deleteAll());
  }
}
