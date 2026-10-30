import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/generated/l10n.dart';

class OwnerChannelHeader extends StatelessWidget {
  final OwnerChannelEntity channel;
  final VoidCallback? onEditTap;

  const OwnerChannelHeader({super.key, required this.channel, this.onEditTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final appTheme = context.appTheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        AppNetworkImage(
          imageUrl: channel.thumbnailUrl ?? '',
          fit: BoxFit.cover,
          errorIcon: Icons.panorama_outlined,
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
        if (onEditTap != null)
          Positioned(
            top: kToolbarHeight,
            right: 16.w,
            child: Material(
              color: appTheme.textPrimary.withValues(alpha: 0.4),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onEditTap,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Icon(
                    Icons.edit,
                    color: appTheme.surfaceColor,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppCircleNetworkImage(
                      imageUrl: channel.channelImageUrl ?? '',
                      radius: 30.r,
                      fallbackText: channel.title,
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            channel.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: appTheme.surfaceColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            '${channel.subscriptionsCount.formatCount()} ${S.current.subscribers} • '
                            '${channel.videosCount.formatCount()} ${S.current.videos} • '
                            '${channel.totalViews.formatCount()} ${S.current.views}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (channel.description != null &&
                    channel.description!.isNotEmpty) ...[
                  12.verticalSpace,
                  Text(
                    channel.description!,
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
