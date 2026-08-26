import 'package:stream_pro/core/error/failures/failure.dart';

class CacheFailure extends Failure {
  const CacheFailure() : super('Cache Error');

  @override
  List<Object?> get props => [message];
}
