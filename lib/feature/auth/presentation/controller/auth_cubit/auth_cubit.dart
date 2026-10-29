import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/error/failures/google_auth_failure.dart';
import 'package:stream_pro/feature/auth/domain/entity/user_entity.dart';
import 'package:stream_pro/feature/auth/domain/use_case/google_login_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GoogleLoginUseCase googleLoginUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _googleLoginUseCase = googleLoginUseCase,
       super(AuthInitial());

  Future<void> login(LoginParams params) async {
    if (state is AuthLoading) return;

    emit(const AuthLoading());

    final result = await _loginUseCase(params);
    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> register(RegisterParams params) async {
    if (state is AuthLoading) return;

    emit(const AuthLoading());

    final result = await _registerUseCase(params);
    if (isClosed) return;

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user, source: AuthSuccessSource.register)),
    );
  }

  Future<void> loginWithGoogle() async {
    if (state is AuthLoading) return;

    emit(const AuthLoading(source: AuthLoadingSource.google));

    final result = await _googleLoginUseCase();
    if (isClosed) return;

    result.fold((failure) {
      if (failure is GoogleAuthFailure && failure.isCancelled) {
        emit(AuthInitial());
        return;
      }
      emit(AuthFailure(failure.message));
    }, (user) => emit(AuthSuccess(user, source: AuthSuccessSource.google)));
  }
}
