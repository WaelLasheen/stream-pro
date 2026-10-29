import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'package:stream_pro/generated/l10n.dart';

class NoOwnerChannelWidget extends StatelessWidget {
  final VoidCallback onCreatePressed;
  final bool isCreating;

  const NoOwnerChannelWidget({
    super.key,
    required this.onCreatePressed,
    this.isCreating = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 80.sp,
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
            ),
            SizedBox(height: 16.h),
            Text(
              S.current.noChannelFound,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              S.current.noChannelFoundMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            SizedBox(height: 24.h),
            AppButton(
              text: S.current.createChannel,
              onPressed: onCreatePressed,
              icon: Icon(Icons.add, size: 20.sp),
              width: context.screenWidth * .65,
            ),
          ],
        ),
      ),
    );
  }
}
