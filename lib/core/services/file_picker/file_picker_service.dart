import 'app_file_type.dart';

abstract class FilePickerService {
  Future<String?> pickFile({
    required AppFileType type,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  });

  Future<List<String>?> pickFiles({
    required AppFileType type,
    bool allowMultiple = true,
    List<String>? allowedExtensions,
  });
}
