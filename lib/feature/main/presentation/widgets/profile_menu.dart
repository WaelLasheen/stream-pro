import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        return AppPopupMenu<String>(
          trigger: AppCircleNetworkImage(
            imageUrl: profile?.avatarUrl ?? '',
            radius: 24.r,
            fallbackText: profile?.name ?? 'U',
          ),
          header: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AppCircleNetworkImage(
                    imageUrl: profile?.avatarUrl ?? '',
                    radius: 24.r,
                    fallbackText: profile?.name ?? 'U',
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          profile?.name ?? 'User',
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
                // context.navigateTo(AppRoutes.profile);
                break;
              case 'owner_channel':
                context.navigateTo(AppRoutes.ownerChannel);
                break;
              case 'logout':
                // context.navigateBack();
                break;
            }
          },
          items: const [
            AppMenuItem(
              value: 'profile',
              title: 'Profile',
              icon: Icons.person_outline_rounded,
            ),
            AppMenuItem(
              value: 'owner_channel',
              title: 'Your Channel',
              icon: Icons.smart_display_outlined,
            ),
            AppMenuItem(
              value: 'logout',
              title: 'Logout',
              icon: Icons.logout_rounded,
            ),
          ],
        );
      },
    );
  }
}
