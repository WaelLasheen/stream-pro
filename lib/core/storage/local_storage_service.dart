abstract class LocalStorageService {
  Future<void> writeString({required String key, required String value});
  Future<void> writeBool({required String key, required bool value});
  Future<void> writeDouble({required String key, required double value});
  Future<void> writeInt({required String key, required int value});

  Future<String?> readString({required String key});
  Future<bool?> readBool({required String key});
  Future<double?> readDouble({required String key});
  Future<int?> readInt({required String key});

  Future<void> delete({required String key});
  Future<void> clearAll();
}