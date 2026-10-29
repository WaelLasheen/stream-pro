import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';

import '../models/session_model.dart';
import 'sessions_remote_datasource.dart';

class SessionsRemoteDataSourceImpl implements SessionsRemoteDataSource {
  final ApiService _apiService;

  SessionsRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<SessionModel>> getSessions() async {
    final response = await _apiService.get(ApiConstants.sessions);
    final envelope = response.data as Map<String, dynamic>?;
    final data = envelope?['data'];
    if (data is! List) return const [];

    return data
        .whereType<Map<String, dynamic>>()
        .map(SessionModel.fromJson)
        .toList();
  }

  @override
  Future<void> revokeSession(String sessionId) async {
    await _apiService.post(ApiConstants.revokeSession(sessionId));
  }

  @override
  Future<void> logoutAll() async {
    await _apiService.post(ApiConstants.logoutAllSessions);
  }
}
