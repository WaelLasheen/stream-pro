import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';

import '../entities/session_entity.dart';

abstract class SessionsRepository {
  Future<Either<Failure, List<SessionEntity>>> getSessions();

  Future<Either<Failure, void>> revokeSession(String sessionId);

  Future<Either<Failure, void>> logoutAll();
}
