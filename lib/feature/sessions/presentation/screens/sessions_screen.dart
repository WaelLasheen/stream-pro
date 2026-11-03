import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/sessions/presentation/controllers/sessions_cubit/sessions_cubit.dart';
import 'package:stream_pro/feature/sessions/presentation/controllers/sessions_cubit/sessions_state.dart';
import 'package:stream_pro/feature/sessions/presentation/widgets/sessions_operation_guard.dart';
import 'package:stream_pro/generated/l10n.dart';

import '../widgets/sessions_view.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionsCubit, SessionsState>(
      builder: (context, state) {
        final isLoggingOutAll =
            state is SessionsLoaded && state.isLoggingOutAll;

        return SessionsOperationGuard(
          isBlocking: isLoggingOutAll,
          child: Scaffold(
            backgroundColor: context.appTheme.backgroundColor,
            appBar: AppBar(title: Text(S.current.currentSessionsTitle)),
            body: const SessionsView(),
          ),
        );
      },
    );
  }
}
