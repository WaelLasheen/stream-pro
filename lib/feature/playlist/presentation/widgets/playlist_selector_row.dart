import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/generated/l10n.dart';

class PlaylistSelectorRow extends StatelessWidget {
  final VideoPlaylistEntity playlist;
  final bool isPending;
  final VoidCallback onTap;

  const PlaylistSelectorRow({
    super.key,
    required this.playlist,
    required this.isPending,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final theme = Theme.of(context);

    return InkWell(
      onTap: isPending ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: appTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: appTheme.boarderPrimary),
              ),
              child: Icon(
                Icons.playlist_play,
                size: 20.r,
                color: appTheme.textSecondary,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    playlist.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: appTheme.textPrimary,
                    ),
                  ),
                  Text(
                    playlist.isPublic ? S.current.public : S.current.private,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: appTheme.textSecondary,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (isPending)
              SizedBox(
                width: 18.w,
                height: 18.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  color: appTheme.primaryColor,
                ),
              )
            else
              Checkbox(
                value: playlist.hasVideo,
                onChanged: (_) => onTap(),
                activeColor: appTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
