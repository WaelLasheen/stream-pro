import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';

import '../entities/session_entity.dart';
import '../repositories/sessions_repository.dart';

class GetSessionsUseCase {
  final SessionsRepository _repository;

  GetSessionsUseCase(this._repository);

  Future<Either<Failure, List<SessionEntity>>> call() {
    return _repository.getSessions();
  }
}
