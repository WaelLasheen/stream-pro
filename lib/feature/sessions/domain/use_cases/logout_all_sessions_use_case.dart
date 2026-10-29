import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';

import '../repositories/sessions_repository.dart';

class LogoutAllSessionsUseCase {
  final SessionsRepository _repository;

  LogoutAllSessionsUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.logoutAll();
  }
}
