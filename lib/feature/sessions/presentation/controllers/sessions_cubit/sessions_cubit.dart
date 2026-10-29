import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/use_cases/get_sessions_use_case.dart';
import '../../../domain/use_cases/logout_all_sessions_use_case.dart';
import '../../../domain/use_cases/revoke_session_use_case.dart';
import 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  final GetSessionsUseCase _getSessionsUseCase;
  final RevokeSessionUseCase _revokeSessionUseCase;
  final LogoutAllSessionsUseCase _logoutAllSessionsUseCase;
  final SessionCleanupService _sessionCleanupService;

  SessionsCubit({
    required GetSessionsUseCase getSessionsUseCase,
    required RevokeSessionUseCase revokeSessionUseCase,
    required LogoutAllSessionsUseCase logoutAllSessionsUseCase,
    required SessionCleanupService sessionCleanupService,
  }) : _getSessionsUseCase = getSessionsUseCase,
       _revokeSessionUseCase = revokeSessionUseCase,
       _logoutAllSessionsUseCase = logoutAllSessionsUseCase,
       _sessionCleanupService = sessionCleanupService,
       super(const SessionsInitial());

  Future<void> ensureLoaded() async {
    if (state is SessionsInitial) {
      await fetchSessions();
    }
  }

  Future<void> fetchSessions() async {
    emit(const SessionsLoading());

    final result = await _getSessionsUseCase();
    if (isClosed) return;

    result.fold((failure) => emit(SessionsError(message: failure.message)), (
      sessions,
    ) {
      final activeSessions =
          sessions.where((session) => session.isActive).toList()
            ..sort(_compareSessions);
      emit(SessionsLoaded(sessions: activeSessions));
    });
  }

  Future<void> revokeSession(SessionEntity session) async {
    final currentSessions = state.sessions;
    final index = currentSessions.indexWhere((item) => item.id == session.id);
    if (index == -1) return;

    final optimisticSessions = [...currentSessions]..removeAt(index);
    emit(
      SessionsLoaded(
        sessions: optimisticSessions,
        isLoggingOutAll: _isLoggingOutAll,
      ),
    );

    final result = await _revokeSessionUseCase(session.id);
    if (isClosed) return;

    result.fold((failure) {
      final latestSessions = [...state.sessions];
      if (latestSessions.every((item) => item.id != session.id)) {
        latestSessions.insert(index.clamp(0, latestSessions.length), session);
      }
      emit(SessionsError(message: failure.message, sessions: latestSessions));
    }, (_) {});
  }

  Future<void> logoutAll() async {
    if (_isLoggingOutAll) return;

    emit(SessionsLoaded(sessions: state.sessions, isLoggingOutAll: true));

    await _logoutAllSessionsUseCase();
    await _sessionCleanupService.clearSession();
    if (isClosed) return;

    emit(const SessionsLoggedOut());
  }

  bool get _isLoggingOutAll {
    final current = state;
    return current is SessionsLoaded && current.isLoggingOutAll;
  }

  int _compareSessions(SessionEntity a, SessionEntity b) {
    final aDate = a.lastUsedAt ?? a.createdAt;
    final bDate = b.lastUsedAt ?? b.createdAt;

    if (aDate == null && bDate == null) return 0;
    if (aDate == null) return 1;
    if (bDate == null) return -1;
    return bDate.compareTo(aDate);
  }
}
