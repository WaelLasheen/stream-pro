import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/dialog_extension.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';
import 'package:stream_pro/generated/l10n.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await context.showConfirmationDialog(
      title: S.current.logout,
      message: S.current.logoutConfirm,
      confirmLabel: S.current.logout,
    );
    if (confirmed != true || !context.mounted) return;

    context.read<ProfileCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileLoggedOut || current is ProfileDeleted,
      listener: (context, state) {
        context.pushAndClearStack(AppRoutes.login);
      },
      builder: (context, state) {
        final profile = state.profile;
        return AppPopupMenu<String>(
          trigger: AppCircleNetworkImage(
            imageUrl: profile?.avatarUrl ?? '',
            radius: 16.r,
            fallbackText: profile?.name ?? S.current.user,
          ),
          header: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AppCircleNetworkImage(
                    imageUrl: profile?.avatarUrl ?? '',
                    radius: 24.r,
                    fallbackText: profile?.name ?? S.current.user,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          profile?.name ?? S.current.user,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: appTheme.textPrimary,
                          ),
                        ),
                        Text(
                          profile?.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: appTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              4.verticalSpace,
              Divider(
                color: appTheme.boarderPrimary,
                indent: 8.w,
                endIndent: 8.w,
              ),
            ],
          ),
          onSelected: (value) {
            switch (value) {
              case 'profile':
                context.navigateTo(AppRoutes.profile);
                break;
              case 'owner_channel':
                context.navigateTo(AppRoutes.ownerChannel);
                break;
              case 'logout':
                _confirmLogout(context);
                break;
            }
          },
          items: [
            AppMenuItem(
              value: 'profile',
              title: S.current.profileTitle,
              icon: Icons.person_outline_rounded,
            ),
            AppMenuItem(
              value: 'owner_channel',
              title: S.current.yourChannel,
              icon: Icons.smart_display_outlined,
            ),
            AppMenuItem(
              value: 'logout',
              title: S.current.logout,
              icon: Icons.logout_rounded,
              iconColor: appTheme.redNormalColor,
              titleColor: appTheme.redNormalColor,
            ),
          ],
        );
      },
    );
  }
}
