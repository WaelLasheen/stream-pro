import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/subscribe_button.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';

class ChannelInfoWidget extends StatelessWidget {
  final String channelTitle;
  final String channelImageUrl;
  final int subscribersCount;
  final bool isSubscribed;
  final String channelId;

  const ChannelInfoWidget({
    super.key,
    required this.channelTitle,
    required this.channelImageUrl,
    required this.subscribersCount,
    required this.isSubscribed,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        InkWell(
          onTap: () {
            context.navigateTo(AppRoutes.channelDetails, arguments: channelId);
          },
          child: AppCircleNetworkImage(radius: 20.r, imageUrl: channelImageUrl),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                channelTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$subscribersCount subscribers',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
        SubscribeButton(channelId: channelId, isSubscribed: isSubscribed),
      ],
    );
  }
}
