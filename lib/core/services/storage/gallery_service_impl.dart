import 'package:gal/gal.dart';
import 'package:stream_pro/core/error/exceptions/gallery_exception.dart';
import 'package:stream_pro/core/services/storage/gallery_service.dart';

class GalleryServiceImpl implements GalleryService {
  const GalleryServiceImpl();

  @override
  Future<void> saveVideo(String filePath) async {
    try {
      await _ensureAccess();

      await Gal.putVideo(filePath);
    } on GalleryException {
      rethrow;
    } catch (_) {
      throw const GalleryException('Failed to save video to gallery');
    }
  }

  Future<void> _ensureAccess() async {
    bool hasAccess = await Gal.hasAccess();
    if (!hasAccess) {
      hasAccess = await Gal.requestAccess();
    }
    if (!hasAccess) {
      throw const GalleryException('Media storage permission denied');
    }
  }
}
