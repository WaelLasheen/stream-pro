import '../models/session_model.dart';

abstract class SessionsRemoteDataSource {
  Future<List<SessionModel>> getSessions();

  Future<void> revokeSession(String sessionId);

  Future<void> logoutAll();
}
