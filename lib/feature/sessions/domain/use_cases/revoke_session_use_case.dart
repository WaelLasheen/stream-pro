import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';

import '../repositories/sessions_repository.dart';

class RevokeSessionUseCase {
  final SessionsRepository _repository;

  RevokeSessionUseCase(this._repository);

  Future<Either<Failure, void>> call(String sessionId) {
    return _repository.revokeSession(sessionId);
  }
}
