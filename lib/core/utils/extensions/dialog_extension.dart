import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

extension DialogExtension on BuildContext {
  Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    required String confirmLabel,
    String? cancelLabel,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(this);
    final appTheme = this.appTheme;
    return showDialog<bool>(
      context: this,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: appTheme.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: cancelLabel ?? S.current.cancel,
                  isPrimary: false,
                  isFullWidth: false,
                  width: double.infinity,
                  borderRadius: 12.r,
                  onPressed: () => Navigator.pop(dialogContext, false),
                  textColor: appTheme.grey800,
                  border: BorderSide(color: appTheme.grey500),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: AppButton(
                  text: confirmLabel,
                  isPrimary: true,
                  isFullWidth: false,
                  width: double.infinity,
                  backgroundColor: isDestructive
                      ? appTheme.redNormalColor
                      : appTheme.primaryColor,
                  textColor: appTheme.surfaceColor,
                  borderRadius: 12.r,
                  onPressed: () => Navigator.pop(dialogContext, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool?> showDeleteConfirmationDialog({
    String? title,
    String? content,
  }) async {
    final theme = Theme.of(this);
    final appTheme = this.appTheme;
    return showDialog<bool>(
      context: this,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: appTheme.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          title ?? S.current.delete,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
        ),
        content: Text(
          content ?? S.current.deleteConfirmationMessage,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: S.current.cancel,
                  isPrimary: false,
                  isFullWidth: false,
                  width: double.infinity,
                  borderRadius: 12.r,
                  onPressed: () => Navigator.pop(dialogContext, false),
                  textColor: appTheme.grey800,
                  border: BorderSide(color: appTheme.grey500),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: AppButton(
                  text: S.current.delete,
                  isPrimary: true,
                  isFullWidth: false,
                  width: double.infinity,
                  backgroundColor: appTheme.redNormalColor,
                  textColor: appTheme.surfaceColor,
                  borderRadius: 12.r,
                  onPressed: () => Navigator.pop(dialogContext, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
