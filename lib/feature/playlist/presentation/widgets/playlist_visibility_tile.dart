import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class PlaylistVisibilityTile extends StatelessWidget {
  final ValueNotifier<bool> isPublic;

  const PlaylistVisibilityTile({super.key, required this.isPublic});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: isPublic,
      builder: (context, value, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: appTheme.boarderPrimary),
          ),
          child: Row(
            children: [
              Icon(
                value ? Icons.public : Icons.lock_outline,
                size: 18.r,
                color: appTheme.textSecondary,
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value ? 'Public' : 'Private',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: appTheme.textPrimary,
                      ),
                    ),
                    Text(
                      value
                          ? 'Anyone can watch this playlist'
                          : 'Only you can watch this playlist',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: appTheme.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: (newValue) => isPublic.value = newValue,
                activeColor: appTheme.onPrimary,
                activeTrackColor: appTheme.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
