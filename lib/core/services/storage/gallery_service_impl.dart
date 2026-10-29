import 'package:gal/gal.dart';
import 'package:stream_pro/core/error/exceptions/gallery_exception.dart';
import 'package:stream_pro/core/services/storage/gallery_service.dart';
import 'package:stream_pro/generated/l10n.dart';

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
      throw GalleryException(S.current.failedToSaveVideoToGallery);
    }
  }

  Future<void> _ensureAccess() async {
    bool hasAccess = await Gal.hasAccess();
    if (!hasAccess) {
      hasAccess = await Gal.requestAccess();
    }
    if (!hasAccess) {
      throw GalleryException(S.current.mediaStoragePermissionDenied);
    }
  }
}
