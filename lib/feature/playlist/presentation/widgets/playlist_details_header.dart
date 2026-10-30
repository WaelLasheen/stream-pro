import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/generated/l10n.dart';

class PlaylistDetailsHeader extends StatelessWidget {
  final PlaylistDetailsEntity playlist;
  final bool isOwner;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PlaylistDetailsHeader({
    super.key,
    required this.playlist,
    this.isOwner = false,
    this.onEdit,
    this.onDelete,
  });

  String get _cover {
    for (final video in playlist.videos) {
      final thumbnail = video.thumbnailUrl;
      if (thumbnail != null && thumbnail.isNotEmpty) return thumbnail;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final appTheme = context.appTheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        AppNetworkImage(
          imageUrl: _cover,
          fit: BoxFit.cover,
          errorIcon: Icons.playlist_play_outlined,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                appTheme.textPrimary.withValues(alpha: 0.15),
                appTheme.textPrimary.withValues(alpha: 0.85),
              ],
            ),
          ),
        ),
        if (isOwner)
          Positioned(
            // Keeps the actions clear of the status bar.
            top: MediaQuery.viewPaddingOf(context).top + 8.h,
            right: 16.w,
            child: Row(
              children: [
                _RoundActionButton(icon: Icons.edit_outlined, onTap: onEdit),
                8.horizontalSpace,
                _RoundActionButton(icon: Icons.delete_outline, onTap: onDelete),
              ],
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    AppCircleNetworkImage(
                      imageUrl: _cover,
                      radius: 28.r,
                      fallbackText: playlist.title,
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            playlist.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: appTheme.surfaceColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          4.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                playlist.isPublic
                                    ? Icons.lock_open_outlined
                                    : Icons.lock_outline,
                                size: 13.r,
                                color: Colors.white70,
                              ),
                              4.horizontalSpace,
                              Text(
                                playlist.isPublic
                                    ? S.current.public
                                    : S.current.private,
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              8.horizontalSpace,
                              Text(
                                '• ${playlist.videos.length.formatCount()} ${S.current.videos}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (playlist.description != null &&
                    playlist.description!.isNotEmpty) ...[
                  10.verticalSpace,
                  Text(
                    playlist.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundActionButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Material(
      color: appTheme.textPrimary.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Icon(icon, color: appTheme.surfaceColor, size: 20.r),
        ),
      ),
    );
  }
}
