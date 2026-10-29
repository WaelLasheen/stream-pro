import 'package:stream_pro/core/error/failures/failure.dart';

class GoogleAuthFailure extends Failure {
  final bool isCancelled;

  const GoogleAuthFailure(super.message, {this.isCancelled = false});

  @override
  List<Object?> get props => [message, isCancelled];
}
