import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

/// Branding block shown at the top of the auth screens:
/// app logo badge, welcome title and screen subtitle.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appTheme.primaryColor, appTheme.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: appTheme.primaryColor.withAlpha(60),
                blurRadius: 16.r,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.play_circle_fill_rounded,
            color: appTheme.surfaceColor,
            size: 36.sp,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          '${S.current.welcomeTo} ${S.current.appTitle}',
          style: context.textTheme.bodyMedium?.copyWith(
            color: appTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: context.textTheme.headlineMedium?.copyWith(
            color: appTheme.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
