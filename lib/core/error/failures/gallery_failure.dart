import 'package:stream_pro/core/error/failures/failure.dart';

class GalleryFailure extends Failure {
  const GalleryFailure([super.message = 'Failed to save video to gallery']);

  @override
  List<Object?> get props => [message];
}
