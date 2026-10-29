import 'package:equatable/equatable.dart';

import '../../../domain/entities/session_entity.dart';

sealed class SessionsState extends Equatable {
  final List<SessionEntity> sessions;

  const SessionsState({this.sessions = const []});

  @override
  List<Object?> get props => [sessions];
}

class SessionsInitial extends SessionsState {
  const SessionsInitial();
}

class SessionsLoading extends SessionsState {
  const SessionsLoading();
}

class SessionsLoaded extends SessionsState {
  final bool isLoggingOutAll;

  const SessionsLoaded({required super.sessions, this.isLoggingOutAll = false});

  SessionsLoaded copyWith({
    List<SessionEntity>? sessions,
    bool? isLoggingOutAll,
  }) {
    return SessionsLoaded(
      sessions: sessions ?? this.sessions,
      isLoggingOutAll: isLoggingOutAll ?? this.isLoggingOutAll,
    );
  }

  @override
  List<Object?> get props => [sessions, isLoggingOutAll];
}

class SessionsError extends SessionsState {
  final String message;

  const SessionsError({required this.message, super.sessions});

  @override
  List<Object?> get props => [message, sessions];
}

class SessionsLoggedOut extends SessionsState {
  const SessionsLoggedOut();
}
