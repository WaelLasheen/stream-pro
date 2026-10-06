import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';

class VideoCardWidget extends StatelessWidget {
  final VideoCardData video;
  final VideoCardVariant variant;
  final VoidCallback? onTap;
  final VoidCallback? onChannelTap;

  const VideoCardWidget({
    super.key,
    required this.video,
    this.variant = VideoCardVariant.vertical,
    this.onTap,
    this.onChannelTap,
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
        child: variant == VideoCardVariant.vertical
            ? _VerticalVideoCard(video: video, onChannelTap: onChannelTap)
            : _HorizontalVideoCard(video: video, onChannelTap: onChannelTap),
      ),
    );
  }
}

class _VerticalVideoCard extends StatelessWidget {
  final VideoCardData video;
  final VoidCallback? onChannelTap;

  const _VerticalVideoCard({required this.video, this.onChannelTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _VideoThumbnail(
          thumbnailUrl: video.thumbnailUrl,
          duration: video.duration,
          height: 180.h,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (video.channel != null)
                AppCircleNetworkImage(
                  imageUrl: video.channel!.avatarUrl,
                  radius: 20.r,
                  fallbackText: video.channel!.name,
                  onTap: onChannelTap,
                ),
              10.horizontalSpace,
              Expanded(
                child: _VideoMetaInfo(
                  title: video.title,
                  channelName: video.channel?.name,
                  views: video.views,
                  publishedTime: video.publishedTime,
                  onChannelTap: onChannelTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HorizontalVideoCard extends StatelessWidget {
  final VideoCardData video;
  final VoidCallback? onChannelTap;

  const _HorizontalVideoCard({required this.video, this.onChannelTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VideoThumbnail(
            thumbnailUrl: video.thumbnailUrl,
            duration: video.duration,
            height: 90.h,
            width: 140.w,
            borderRadius: BorderRadius.circular(12.r),
          ),
          10.horizontalSpace,
          Expanded(
            child: _VideoMetaInfo(
              title: video.title,
              description: video.description,
              channelName: video.channel?.name,
              views: video.views,
              publishedTime: video.publishedTime,
              onChannelTap: onChannelTap,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SMALL REUSABLE PRIVATE WIDGETS
// =============================================================================

class _VideoThumbnail extends StatelessWidget {
  final String thumbnailUrl;
  final int duration;
  final double height;
  final double? width;
  final BorderRadius borderRadius;

  const _VideoThumbnail({
    required this.thumbnailUrl,
    required this.duration,
    required this.height,
    this.width,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    return Stack(
      children: [
        AppNetworkImage(
          imageUrl: thumbnailUrl,
          borderRadius: borderRadius,
          height: height,
          width: width ?? context.screenWidth,
          errorIcon: Icons.movie_outlined,
        ),
        Positioned(
          bottom: 6.h,
          right: 6.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: appTheme.overlayColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              duration.formatDuration(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: appTheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoMetaInfo extends StatelessWidget {
  final String title;
  final String? description;
  final String? channelName;
  final int views;
  final DateTime? publishedTime;
  final VoidCallback? onChannelTap;

  const _VideoMetaInfo({
    required this.title,
    this.description,
    this.channelName,
    required this.views,
    this.publishedTime,
    this.onChannelTap,
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
        if (description != null) ...[
          4.verticalSpace,
          Text(
            description!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: theme.hintColor,
              fontSize: 10.sp,
              height: 1.2,
            ),
          ),
        ],
        4.verticalSpace,
        if (channelName != null)
          InkWell(
            onTap: onChannelTap,
            child: Text(
              channelName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
                fontSize: 11.sp,
              ),
            ),
          ),
        2.verticalSpace,
        Row(
          spacing: 4.w,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${views.formatCount()} views",
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.hintColor,
                fontSize: 10.sp,
              ),
            ),
            if (publishedTime != null)
              Text(
                publishedTime!.timeAgo(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.hintColor,
                  fontSize: 10.sp,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
