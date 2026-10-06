import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_pro/core/error/exceptions/cache_exception.dart';
import 'local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences _pref;
  LocalStorageServiceImpl(this._pref);

  // ---------------------- Helper Guard Methods ----------------------

  Future<T> _exceptionGuard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw CacheException(
        'Failed to execute local storage operation, ${e.toString()}',
      );
    }
  }

  T _exceptionGuardSync<T>(T Function() action) {
    try {
      return action();
    } catch (e) {
      throw CacheException(
        'Failed to execute local storage operation, ${e.toString()}',
      );
    }
  }

  // ---------------------- Implementation ----------------------

  @override
  Future<void> writeString({required String key, required String value}) {
    return _exceptionGuard(() => _pref.setString(key, value));
  }

  @override
  Future<void> writeBool({required String key, required bool value}) {
    return _exceptionGuard(() => _pref.setBool(key, value));
  }

  @override
  Future<void> writeDouble({required String key, required double value}) {
    return _exceptionGuard(() => _pref.setDouble(key, value));
  }

  @override
  Future<void> writeInt({required String key, required int value}) {
    return _exceptionGuard(() => _pref.setInt(key, value));
  }

  @override
  Future<String?> readString({required String key}) async {
    return _exceptionGuardSync(() => _pref.getString(key));
  }

  @override
  Future<bool?> readBool({required String key}) async {
    return _exceptionGuardSync(() => _pref.getBool(key));
  }

  @override
  Future<double?> readDouble({required String key}) async {
    return _exceptionGuardSync(() => _pref.getDouble(key));
  }

  @override
  Future<int?> readInt({required String key}) async {
    return _exceptionGuardSync(() => _pref.getInt(key));
  }

  @override
  Future<void> delete({required String key}) {
    return _exceptionGuard(() => _pref.remove(key));
  }

  @override
  Future<void> clearAll() {
    return _exceptionGuard(() => _pref.clear());
  }
}
