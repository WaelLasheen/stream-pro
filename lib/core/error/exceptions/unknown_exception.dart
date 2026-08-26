import 'package:stream_pro/core/error/exceptions/app_exception.dart';

class UnknownException extends AppException {
  final StackTrace? stackTrace;

  const UnknownException([
    super.message = "Unknown Exception",
    this.stackTrace,
  ]);

  @override
  List<Object?> get props => [super.message, stackTrace];
}
