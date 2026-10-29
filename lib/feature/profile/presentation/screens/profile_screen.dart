import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/utils/extensions/dialog_extension.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_account_actions_card.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_edit_sheet.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_header_card.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_shimmer.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_stat_card.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/settings_section.dart';
import 'package:stream_pro/feature/sessions/presentation/widgets/sessions_view.dart';
import 'package:stream_pro/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  final FilePickerService filePickerService;

  const ProfileScreen({super.key, required this.filePickerService});

  void _openEditSheet(BuildContext context, ProfileEntity profile) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: ProfileEditSheet(
          profile: profile,
          filePickerService: filePickerService,
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await context.showConfirmationDialog(
      title: S.current.logout,
      message: S.current.logoutConfirm,
      confirmLabel: S.current.logout,
    );
    if (confirmed != true || !context.mounted) return;

    context.read<ProfileCubit>().logout();
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirmed = await context.showConfirmationDialog(
      title: S.current.deleteAccount,
      message: S.current.deleteAccountMessage,
      confirmLabel: S.current.delete,
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    context.read<ProfileCubit>().deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return DefaultTabController(
      length: 2,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            current is ProfileDeleted ||
            current is ProfileLoggedOut ||
            (current is ProfileError && current.profile != null),
        listener: (context, state) {
          if (state is ProfileDeleted || state is ProfileLoggedOut) {
            context.pushAndClearStack(AppRoutes.login);
            return;
          }
          if (state is ProfileError) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        builder: (context, state) {
          final profile = state.profile;

          Widget overviewBody;
          if (state is ProfileError && profile == null) {
            overviewBody = AppErrorWidget(
              message: state.message,
              onRetry: () => context.read<ProfileCubit>().fetchProfile(),
              icon: Icons.wifi_off_rounded,
              iconSize: 56.r,
            );
          } else if (profile == null) {
            overviewBody = const ProfileShimmer();
          } else {
            final isSaving = state is ProfileLoaded && state.isSaving;
            final isDeleting = state is ProfileLoaded && state.isDeleting;
            final isLoggingOut = state is ProfileLoaded && state.isLoggingOut;

            overviewBody = AppRefreshIndicator(
              onRefresh: () => context.read<ProfileCubit>().fetchProfile(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(16.r),
                children: [
                  ProfileHeaderCard(
                    profile: profile,
                    isSaving: isSaving,
                    onAvatarTap: () => _openEditSheet(context, profile),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: ProfileStatCard(
                          icon: Icons.video_library_outlined,
                          value: profile.videoCount.formatCount(),
                          label: S.current.videosLabel,
                          color: appTheme.primaryColor,
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: ProfileStatCard(
                          icon: Icons.visibility_outlined,
                          value: profile.totalViews.formatCount(),
                          label: S.current.totalViewsLabel,
                          color: appTheme.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  SettingsSection(),
                  24.verticalSpace,

                  ProfileAccountActionsCard(
                    isLoggingOut: isLoggingOut,
                    isDeleting: isDeleting,
                    onLogout: () => _confirmLogout(context),
                    onDeleteAccount: () => _confirmDeleteAccount(context),
                  ),
                ],
              ),
            );
          }

          return Scaffold(
            backgroundColor: appTheme.backgroundColor,
            appBar: AppBar(
              title: Text(S.current.profileTitle),
              actions: [
                if (profile != null)
                  IconButton(
                    tooltip: S.current.editProfilePage,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _openEditSheet(context, profile),
                  ),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: S.current.profileTitle),
                  Tab(text: S.current.sessionsTab),
                ],
              ),
            ),
            body: TabBarView(children: [overviewBody, const SessionsView()]),
          );
        },
      ),
    );
  }
}
