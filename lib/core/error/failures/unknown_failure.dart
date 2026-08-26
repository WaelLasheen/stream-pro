import 'package:stream_pro/core/error/failures/failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);

  @override
  List<Object?> get props => [message];
}
