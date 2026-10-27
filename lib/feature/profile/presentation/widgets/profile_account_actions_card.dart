import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

class ProfileAccountActionsCard extends StatelessWidget {
  final bool isLoggingOut;
  final bool isDeleting;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const ProfileAccountActionsCard({
    super.key,
    required this.isLoggingOut,
    required this.isDeleting,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final isBusy = isLoggingOut || isDeleting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
          child: Text(
            S.current.accountActions,
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
              ListTile(
                enabled: !isBusy,
                leading: Icon(
                  Icons.logout_rounded,
                  color: appTheme.textSecondary,
                ),
                title: Text(
                  S.current.logout,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: appTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: isLoggingOut
                    ? SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: CircularProgressIndicator(strokeWidth: 2.r),
                      )
                    : Icon(
                        Icons.chevron_right_rounded,
                        color: appTheme.grey600,
                      ),
                onTap: isBusy ? null : onLogout,
              ),
              Divider(height: 1, color: appTheme.boarderPrimary, indent: 56.w),
              ListTile(
                enabled: !isBusy,
                leading: Icon(
                  Icons.delete_outline_rounded,
                  color: appTheme.redNormalColor,
                ),
                title: Text(
                  S.current.deleteAccount,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: appTheme.redNormalColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: isDeleting
                    ? SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.r,
                          color: appTheme.redNormalColor,
                        ),
                      )
                    : Icon(
                        Icons.chevron_right_rounded,
                        color: appTheme.grey600,
                      ),
                onTap: isBusy ? null : onDeleteAccount,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
