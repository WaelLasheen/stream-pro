import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/stream_pro_logo.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

const _authLogoHeroTag = 'auth_logo';

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
        Hero(
          tag: _authLogoHeroTag,
          child: StreamProLogo(size: 64.w, width: 64.w),
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
