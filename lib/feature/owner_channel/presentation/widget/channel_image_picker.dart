import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class ChannelCoverPicker extends StatelessWidget {
  final String? networkUrl;
  final ValueNotifier<String?> pickedPathNotifier;
  final VoidCallback onTap;

  const ChannelCoverPicker({
    super.key,
    required this.networkUrl,
    required this.pickedPathNotifier,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appTheme = context.appTheme;

    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: pickedPathNotifier,
            builder: (context, pickedPath, _) {
              if (pickedPath != null) {
                return Image.file(
                  File(pickedPath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              }

              if (networkUrl != null && networkUrl!.isNotEmpty) {
                return AppNetworkImage(
                  imageUrl: networkUrl!,
                  fit: BoxFit.cover,
                );
              }

              return Container(
                color: isDark ? appTheme.surfaceDark : appTheme.borderLight,
                child: Center(
                  child: Icon(
                    Icons.panorama_outlined,
                    size: 48.r,
                    color: appTheme.textSecondary,
                  ),
                ),
              );
            },
          ),
          Container(color: appTheme.textPrimary.withValues(alpha: 0.2)),
          Center(
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: appTheme.textPrimary.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                color: appTheme.surfaceColor,
                size: 28.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChannelAvatarPicker extends StatelessWidget {
  final String? networkUrl;
  final ValueNotifier<String?> pickedPathNotifier;
  final String fallbackText;
  final VoidCallback onTap;

  const ChannelAvatarPicker({
    super.key,
    required this.networkUrl,
    required this.pickedPathNotifier,
    required this.fallbackText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = 45.r;
    final appTheme = context.appTheme;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Stack(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: pickedPathNotifier,
            builder: (context, pickedPath, _) {
              if (pickedPath != null) {
                return CircleAvatar(
                  radius: radius,
                  backgroundImage: FileImage(File(pickedPath)),
                );
              }

              if (networkUrl != null && networkUrl!.isNotEmpty) {
                return AppCircleNetworkImage(
                  imageUrl: networkUrl!,
                  radius: radius,
                  fallbackText: fallbackText,
                );
              }

              return CircleAvatar(
                radius: radius,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.person_outline,
                  size: 40.r,
                  color: theme.hintColor,
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: appTheme.accentPurple,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 2.w,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                color: appTheme.surfaceColor,
                size: 16.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
