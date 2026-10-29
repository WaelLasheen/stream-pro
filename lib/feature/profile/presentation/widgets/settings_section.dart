import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/app_config/app_config_cubit.dart';
import 'package:stream_pro/core/app_config/app_config_state.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
          child: Text(
            S.current.settings,
            style: context.textTheme.titleSmall?.copyWith(
              color: appTheme.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: appTheme.surfaceColor,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: appTheme.boarderPrimary),
          ),
          child: Column(
            children: [
              // Language Selector
              BlocBuilder<AppConfigCubit, AppConfigState>(
                builder: (context, configState) {
                  return ListTile(
                    leading: Icon(
                      Icons.language_rounded,
                      color: appTheme.textSecondary,
                    ),
                    title: Text(
                      S.current.language,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: appTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: AppPopupMenu<String>(
                      trigger: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            configState.locale.languageCode == 'ar'
                                ? S.current.arabic
                                : S.current.english,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: appTheme.textSecondary,
                            ),
                          ),
                          4.horizontalSpace,
                          Icon(
                            Icons.chevron_right_rounded,
                            color: appTheme.grey600,
                            size: 20.r,
                          ),
                        ],
                      ),
                      items: [
                        AppMenuItem(
                          value: 'en',
                          title: S.current.english,
                          icon: Icons.language,
                        ),
                        AppMenuItem(
                          value: 'ar',
                          title: S.current.arabic,
                          icon: Icons.language,
                        ),
                      ],
                      onSelected: (lang) {
                        context.read<AppConfigCubit>().changeLanguage(lang);
                      },
                    ),
                  );
                },
              ),
              Divider(height: 1, color: appTheme.boarderPrimary, indent: 56.w),

              // Theme Selector
              BlocBuilder<AppConfigCubit, AppConfigState>(
                builder: (context, configState) {
                  String themeLabel;
                  switch (configState.themeMode) {
                    case ThemeMode.light:
                      themeLabel = S.current.lightTheme;
                      break;
                    case ThemeMode.dark:
                      themeLabel = S.current.darkTheme;
                      break;
                    case ThemeMode.system:
                      themeLabel = S.current.systemTheme;
                      break;
                  }
                  return ListTile(
                    leading: Icon(
                      Icons.brightness_6_rounded,
                      color: appTheme.textSecondary,
                    ),
                    title: Text(
                      S.current.theme,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: appTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: AppPopupMenu<ThemeMode>(
                      trigger: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            themeLabel,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: appTheme.textSecondary,
                            ),
                          ),
                          4.horizontalSpace,
                          Icon(
                            Icons.chevron_right_rounded,
                            color: appTheme.grey600,
                            size: 20.r,
                          ),
                        ],
                      ),
                      items: [
                        AppMenuItem(
                          value: ThemeMode.light,
                          title: S.current.lightTheme,
                          icon: Icons.light_mode_outlined,
                        ),
                        AppMenuItem(
                          value: ThemeMode.dark,
                          title: S.current.darkTheme,
                          icon: Icons.dark_mode_outlined,
                        ),
                        AppMenuItem(
                          value: ThemeMode.system,
                          title: S.current.systemTheme,
                          icon: Icons.brightness_auto_outlined,
                        ),
                      ],
                      onSelected: (theme) {
                        context.read<AppConfigCubit>().changeTheme(theme);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
