import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';

import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/sessions_repository.dart';
import '../datasources/sessions_remote_datasource.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsRemoteDataSource remoteDataSource;

  SessionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SessionEntity>>> getSessions() {
    return safeCall(() async {
      final models = await remoteDataSource.getSessions();
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> revokeSession(String sessionId) {
    return safeCall(() => remoteDataSource.revokeSession(sessionId));
  }

  @override
  Future<Either<Failure, void>> logoutAll() {
    return safeCall(() => remoteDataSource.logoutAll());
  }
}
