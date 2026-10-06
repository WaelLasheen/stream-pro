import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';

class EditThumbnailSection extends StatelessWidget {
  final String networkUrl; 
  final ValueNotifier<String?> pendingThumbnailPathNotifier; 
  final bool isUploading;
  final bool enabled;
  final VoidCallback onChange;

  const EditThumbnailSection({
    super.key,
    required this.networkUrl,
    required this.pendingThumbnailPathNotifier, 
    required this.isUploading,
    required this.enabled,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 1. Listen to the notifier so the UI rebuilds when a new file is picked
    return ValueListenableBuilder<String?>(
      valueListenable: pendingThumbnailPathNotifier,
      builder: (context, localImagePath, _) {
        // 2. Determine what to show based on the pending state
        Widget imageWidget;
        if (localImagePath != null) {
          imageWidget = Image.file(
            File(localImagePath),
            width: 120.w,
            height: 68.h,
            fit: BoxFit.cover,
          );
        } else if (networkUrl.isNotEmpty) {
          imageWidget = AppNetworkImage(
            imageUrl: networkUrl,
            fit: BoxFit.cover,
            errorIcon: Icons.image_not_supported,
          );
        } else {
          imageWidget = ColoredBox(
            color: theme.colorScheme.surfaceContainerHighest,
          );
        }

        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(width: 120.w, height: 68.h, child: imageWidget),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppButton(
                text: isUploading ? 'Uploading...' : 'Change thumbnail',
                onPressed: enabled ? onChange : () {},
                isLoading: isUploading,
                isPrimary: false,
                icon: Icon(
                  isUploading ? null : Icons.image_outlined,
                  size: 18.sp,
                  color: theme.primaryColor,
                ),
                height: 44.h,
                borderRadius: 8.r,
              ),
            ),
          ],
        );
      },
    );
  }
}
