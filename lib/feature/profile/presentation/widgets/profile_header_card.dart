import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/generated/l10n.dart';

class ProfileHeaderCard extends StatelessWidget {
  final ProfileEntity profile;
  final bool isSaving;
  final VoidCallback onAvatarTap;

  const ProfileHeaderCard({
    super.key,
    required this.profile,
    required this.isSaving,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: appTheme.boarderPrimary),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onAvatarTap,
            child: Stack(
              children: [
                AppCircleNetworkImage(
                  imageUrl: profile.avatarUrl ?? '',
                  radius: 48.r,
                  fallbackText: profile.name,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: BoxDecoration(
                      color: appTheme.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: appTheme.surfaceColor,
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 14.r,
                      color: appTheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Text(
            profile.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: appTheme.textPrimary,
            ),
          ),
          6.verticalSpace,
          Text(
            profile.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: appTheme.textSecondary,
            ),
          ),
          10.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 13.r,
                color: appTheme.grey700,
              ),
              6.horizontalSpace,
              Text(
                '${S.current.memberSince} '
                '${MaterialLocalizations.of(context).formatMediumDate(profile.createdAt)}',
                style: textTheme.bodySmall?.copyWith(color: appTheme.grey700),
              ),
            ],
          ),
          if (isSaving) ...[
            18.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                minHeight: 4.h,
                backgroundColor: appTheme.grey200,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
