import 'package:stream_pro/core/error/failures/failure.dart';

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object?> get props => [message];
}
