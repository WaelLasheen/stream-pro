import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class FilePickTile extends StatelessWidget {
  final PlatformFile? file;
  final bool isImage;
  final IconData icon;
  final String emptyTitle;
  final String emptySubtitle;
  final bool enabled;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const FilePickTile({
    super.key,
    required this.file,
    required this.icon,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.onPick,
    required this.onClear,
    this.isImage = false,
    this.enabled = true,
  });

  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final selected = file;

    if (selected == null) {
      return InkWell(
        onTap: enabled ? onPick : null,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40.sp, color: theme.primaryColor),
              SizedBox(height: 8.h),
              Text(emptyTitle, style: FontStyles.bodyMedium),
              SizedBox(height: 4.h),
              Text(
                emptySubtitle,
                style: FontStyles.bodySmall.copyWith(color: theme.hintColor),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appTheme.successColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          if (isImage && selected.path != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.file(
                File(selected.path!),
                width: 70.w,
                height: 50.h,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: appTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.check_circle, color: appTheme.successColor),
            ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selected.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.titleSmall,
                ),
                SizedBox(height: 4.h),
                Text(
                  formatFileSize(selected.size),
                  style: FontStyles.bodySmall.copyWith(color: theme.hintColor),
                ),
              ],
            ),
          ),
          if (enabled)
            IconButton(
              icon: Icon(Icons.close, color: appTheme.errorColor),
              onPressed: onClear,
            ),
        ],
      ),
    );
  }
}
