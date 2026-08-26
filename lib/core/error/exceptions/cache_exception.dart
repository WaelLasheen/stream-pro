import 'package:stream_pro/core/error/exceptions/app_exception.dart';

class CacheException extends AppException {
  const CacheException([super.message = 'Cache Exception']);

  @override
  List<Object?> get props => [super.message];
}
