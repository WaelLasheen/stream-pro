part of 'auth_cubit.dart';

enum AuthLoadingSource { local, google }

enum AuthSuccessSource { login, register, google }

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final AuthLoadingSource source;

  const AuthLoading({this.source = AuthLoadingSource.local});

  @override
  List<Object?> get props => [source];
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final AuthSuccessSource source;

  const AuthSuccess(this.user, {this.source = AuthSuccessSource.login});

  @override
  List<Object?> get props => [user, source];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
