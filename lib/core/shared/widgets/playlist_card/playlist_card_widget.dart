import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_data.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';

class PlaylistCardWidget extends StatelessWidget {
  final PlaylistCardData playlist;
  final PlaylistCardVariant variant;
  final VoidCallback? onTap;

  const PlaylistCardWidget({
    super.key,
    required this.playlist,
    this.variant = PlaylistCardVariant.vertical,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: context.screenWidth,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: appTheme.grey800.withAlpha(14),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: variant == PlaylistCardVariant.vertical
            ? _VerticalPlaylistCard(playlist: playlist)
            : _HorizontalPlaylistCard(playlist: playlist),
      ),
    );
  }
}

class _VerticalPlaylistCard extends StatelessWidget {
  final PlaylistCardData playlist;
  const _VerticalPlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PlaylistThumbnail(
          thumbnails: playlist.thumbnails,
          videosCount: playlist.videosCount,
          height: 180.h,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        Padding(
          padding: EdgeInsets.all(12.r),
          child: _PlaylistMetaInfo(
            title: playlist.title,
            description: playlist.description,
            isPublic: playlist.isPublic,
          ),
        ),
      ],
    );
  }
}

class _HorizontalPlaylistCard extends StatelessWidget {
  final PlaylistCardData playlist;
  const _HorizontalPlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlaylistThumbnail(
            thumbnails: playlist.thumbnails,
            videosCount: playlist.videosCount,
            height: 90.h,
            width: 140.w,
            borderRadius: BorderRadius.circular(12.r),
          ),
          10.horizontalSpace,
          Expanded(
            child: _PlaylistMetaInfo(
              title: playlist.title,
              description: playlist.description,
              isPublic: playlist.isPublic,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistThumbnail extends StatelessWidget {
  final List<String> thumbnails;
  final int videosCount;
  final double height;
  final double? width;
  final BorderRadius borderRadius;

  const _PlaylistThumbnail({
    required this.thumbnails,
    required this.videosCount,
    required this.height,
    this.width,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    final primaryImage = thumbnails.isNotEmpty ? thumbnails[0] : '';
    final secondaryImage = thumbnails.length > 1 ? thumbnails[1] : null;

    return Stack(
      children: [
        // Background/Secondary Image (Stacked effect)
        if (secondaryImage != null)
          AppNetworkImage(
            imageUrl: secondaryImage,
            height: height,
            width: width ?? double.infinity,
            fit: BoxFit.cover,
            borderRadius: borderRadius,
            color: Colors.black.withValues(alpha: 0.3),
            colorBlendMode: BlendMode.darken,
          ),

        // Primary Image
        AppNetworkImage(
          imageUrl: primaryImage,
          height: height,
          width: width ?? double.infinity,
          fit: BoxFit.cover,
          borderRadius: borderRadius,
          errorIcon: Icons.playlist_play_outlined,
        ),

        // Right side overlay indicating video count
        Positioned.fill(
          right: 0,
          top: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 45.w,
                color: appTheme.overlayColor.withValues(alpha: 0.85),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.playlist_play,
                      color: appTheme.onPrimary,
                      size: 20.r,
                    ),
                    4.verticalSpace,
                    Text(
                      '$videosCount',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: appTheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaylistMetaInfo extends StatelessWidget {
  final String title;
  final String? description;
  final bool isPublic;

  const _PlaylistMetaInfo({
    required this.title,
    this.description,
    required this.isPublic,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            height: 1.25,
          ),
        ),
        4.verticalSpace,
        Row(
          children: [
            Icon(
              isPublic ? Icons.lock_open_outlined : Icons.lock_outline,
              size: 12.r,
              color: theme.hintColor,
            ),
            4.horizontalSpace,
            Text(
              isPublic ? 'Public' : 'Private',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        if (description != null && description!.isNotEmpty) ...[
          4.verticalSpace,
          Text(
            description!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      ],
    );
  }
}
