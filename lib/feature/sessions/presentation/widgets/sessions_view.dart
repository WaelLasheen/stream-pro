import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/utils/extensions/dialog_extension.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/generated/l10n.dart';

import '../../domain/entities/session_entity.dart';
import '../controllers/sessions_cubit/sessions_cubit.dart';
import '../controllers/sessions_cubit/sessions_state.dart';
import 'session_card.dart';
import 'sessions_shimmer.dart';

class SessionsView extends StatelessWidget {
  const SessionsView({super.key});

  Future<void> _confirmRevoke(
    BuildContext context,
    SessionEntity session,
  ) async {
    final confirmed = await context.showConfirmationDialog(
      title: S.current.logoutSessionConfirmTitle,
      message: S.current.logoutSessionConfirmMessage,
      confirmLabel: S.current.logoutSession,
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    context.read<SessionsCubit>().revokeSession(session);
  }

  Future<void> _confirmLogoutAll(BuildContext context) async {
    final confirmed = await context.showConfirmationDialog(
      title: S.current.logoutAllConfirmTitle,
      message: S.current.logoutAllConfirmMessage,
      confirmLabel: S.current.logout,
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    context.read<SessionsCubit>().logoutAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionsCubit, SessionsState>(
      listenWhen: (previous, current) {
        if (current is SessionsLoggedOut) return true;
        return current is SessionsError &&
            (previous is! SessionsError || previous.message != current.message);
      },
      listener: (context, state) {
        if (state is SessionsLoggedOut) {
          context.pushAndClearStack(AppRoutes.login);
          return;
        }
        if (state is SessionsError) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        switch (state) {
          case SessionsInitial():
          case SessionsLoading():
            return const SessionsShimmer();

          case SessionsLoggedOut():
            return const SizedBox.shrink();

          case SessionsLoaded():
            return _SessionsList(
              sessions: state.sessions,
              isLoggingOutAll: state.isLoggingOutAll,
              onRevoke: (session) => _confirmRevoke(context, session),
              onLogoutAll: () => _confirmLogoutAll(context),
            );

          case SessionsError():
            if (state.sessions.isEmpty) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<SessionsCubit>().fetchSessions(),
                icon: Icons.wifi_off_rounded,
                retryIcon: Icons.refresh,
              );
            }

            return _SessionsList(
              sessions: state.sessions,
              isLoggingOutAll: false,
              onRevoke: (session) => _confirmRevoke(context, session),
              onLogoutAll: () => _confirmLogoutAll(context),
            );
        }
      },
    );
  }
}

class _SessionsList extends StatelessWidget {
  final List<SessionEntity> sessions;
  final bool isLoggingOutAll;
  final ValueChanged<SessionEntity> onRevoke;
  final VoidCallback onLogoutAll;

  const _SessionsList({
    required this.sessions,
    required this.isLoggingOutAll,
    required this.onRevoke,
    required this.onLogoutAll,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return AppRefreshIndicator(
      onRefresh: () => context.read<SessionsCubit>().fetchSessions(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.currentSessionsTitle,
                  style: textTheme.titleLarge?.copyWith(
                    color: appTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: appTheme.primaryTint,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${sessions.length}',
                  style: textTheme.labelMedium?.copyWith(
                    color: appTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Text(
            S.current.currentSessionsSubtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: appTheme.textSecondary,
            ),
          ),
          16.verticalSpace,
          if (sessions.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 28.h),
              decoration: BoxDecoration(
                color: appTheme.surfaceColor,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: appTheme.boarderPrimary),
              ),
              child: AppEmptyWidget(
                icon: Icons.devices_other_rounded,
                message: S.current.noActiveSessionsMessage,
              ),
            )
          else
            for (var index = 0; index < sessions.length; index++) ...[
              SessionCard(
                session: sessions[index],
                onRevoke: () => onRevoke(sessions[index]),
              ),
              if (index != sessions.length - 1) 12.verticalSpace,
            ],
          24.verticalSpace,
          AppButton(
            text: S.current.logoutAllDevices,
            isPrimary: false,
            isFullWidth: false,
            width: double.infinity,
            height: 46.h,
            border: BorderSide(color: appTheme.redNormalColor),
            textColor: appTheme.redNormalColor,
            icon: Icon(Icons.logout_rounded, size: 18.r),
            isLoading: isLoggingOutAll,
            onPressed: onLogoutAll,
          ),
        ],
      ),
    );
  }
}
