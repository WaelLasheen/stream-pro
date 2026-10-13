import 'package:stream_pro/core/error/exceptions/app_exception.dart';

class GalleryException extends AppException {
  const GalleryException([super.message = 'Gallery Exception']);

  @override
  List<Object?> get props => [message];
}