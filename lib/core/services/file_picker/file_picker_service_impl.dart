import 'package:file_picker/file_picker.dart' as fp;
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';
import 'file_picker_service.dart';
import 'app_file_type.dart';

class FilePickerServiceImpl implements FilePickerService {
  @override
  Future<String?> pickFile({
    required AppFileType type,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  }) async {
    try {
      final result = await fp.FilePicker.pickFiles(
        type: _mapFileType(type),
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      return result.files.first.path;
    } catch (e) {
      AppDebuggingPrint.printDebug(e.toString());
      return null;
    }
  }

  @override
  Future<List<String>?> pickFiles({
    required AppFileType type,
    bool allowMultiple = true,
    List<String>? allowedExtensions,
  }) async {
    try {
      final result = await fp.FilePicker.pickFiles(
        type: _mapFileType(type),
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      // Filter out null paths (can happen on web)
      return result.files.map((file) => file.path).whereType<String>().toList();
    } catch (e) {
      return null;
    }
  }

  fp.FileType _mapFileType(AppFileType type) {
    switch (type) {
      case AppFileType.image:
        return fp.FileType.image;
      case AppFileType.video:
        return fp.FileType.video;
      case AppFileType.audio:
        return fp.FileType.audio;
      case AppFileType.any:
        return fp.FileType.any;
      case AppFileType.custom:
        return fp.FileType.custom;
    }
  }
}
