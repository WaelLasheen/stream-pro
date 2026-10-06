import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/auth/domain/use_case/refresh_token_use_case.dart';

part 'splash_state.dart';

/// Total duration of the entrance animation.
/// The cubit waits for whichever is longer: this or the refresh call.
const Duration kSplashAnimationDuration = Duration(milliseconds: 500);

class SplashCubit extends Cubit<SplashState> {
  final RefreshTokenUseCase refreshTokenUseCase;

  SplashCubit({required this.refreshTokenUseCase}) : super(SplashInitial());

  Future<void> start() async {
    final stopwatch = Stopwatch()..start();

    // 1. Try to refresh the session
    final result = await refreshTokenUseCase();

    // 2. If the response was faster than the animation, wait for the rest
    stopwatch.stop();
    final remaining = kSplashAnimationDuration - stopwatch.elapsed;
    if (remaining > Duration.zero) {
      await Future.delayed(remaining);
    }

    if (isClosed) return;

    // 3. Navigate based on the refresh result
    result.fold(
      (_) => emit(SplashUnauthenticated()),
      (_) => emit(SplashAuthenticated()),
    );
  }
}
