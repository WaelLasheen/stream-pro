import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/subscribe_button.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/generated/l10n.dart'; 

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

  void _handleChannelTap(BuildContext context) {
    context.navigateToChannelDetails(channelId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        InkWell(
          onTap: () => _handleChannelTap(context),
          child: AppCircleNetworkImage(radius: 20.r, imageUrl: channelImageUrl),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _handleChannelTap(context),
                child: Text(
                  channelTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$subscribersCount ${S.current.subscribers}',
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
