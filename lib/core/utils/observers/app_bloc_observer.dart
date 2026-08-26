import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppDebuggingPrint.printDebug('✨ [onCreate] -> ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppDebuggingPrint.printDebug(
      '📌 [onEvent] -> ${bloc.runtimeType} | Event: ${event.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppDebuggingPrint.printDebug(
      '🔴 [onError] -> ${bloc.runtimeType} | Error: $error',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppDebuggingPrint.printDebug(
      '🔄 [onTransition] -> ${bloc.runtimeType}\n'
      '   From: ${transition.currentState}\n'
      '   Event: ${transition.event.runtimeType}\n'
      '   To:   ${transition.nextState}',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppDebuggingPrint.printDebug(
      '🟢 [onChange] -> ${bloc.runtimeType}\n'
      '   Current: ${change.currentState}\n'
      '   Next:    ${change.nextState}',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppDebuggingPrint.printDebug('🗑️ [onClose] -> ${bloc.runtimeType}');
  }
}
