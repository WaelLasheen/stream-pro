import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelInfoWidget extends StatefulWidget {
  final String channelTitle;
  final String channelImageUrl;
  final int subscribersCount;
  final bool isSubscribed;

  const ChannelInfoWidget({
    super.key,
    required this.channelTitle,
    required this.channelImageUrl,
    required this.subscribersCount,
    required this.isSubscribed,
  });

  @override
  State<ChannelInfoWidget> createState() => _ChannelInfoWidgetState();
}

class _ChannelInfoWidgetState extends State<ChannelInfoWidget> {
  late bool isSubscribed;

  @override
  void initState() {
    super.initState();
    isSubscribed = widget.isSubscribed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: CachedNetworkImageProvider(widget.channelImageUrl),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.channelTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.subscribersCount} subscribers',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSubscribed
                ? theme.colorScheme.surfaceContainerHighest
                : theme.colorScheme.primary,
            foregroundColor: isSubscribed
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          ),
          onPressed: () {
            setState(() {
              isSubscribed = !isSubscribed;
            });
          },
          child: Text(isSubscribed ? 'Subscribed' : 'Subscribe'),
        ),
      ],
    );
  }
}