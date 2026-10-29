import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_details_cubit/channel_details_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_details_cubit/channel_details_state.dart';
import 'package:stream_pro/core/shared/widgets/channel/channel_header_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/subscribe_button.dart';
import 'package:stream_pro/generated/l10n.dart';

class ChannelHeader extends StatelessWidget {
  final ChannelDetailsState state;
  final String channelId;

  const ChannelHeader({
    super.key,
    required this.state,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ChannelDetailsInitialState():
      case ChannelDetailsLoadingState():
        return const ChannelHeaderShimmer();

      case ChannelDetailsLoadedState():
        final loadedState = state as ChannelDetailsLoadedState;
        final details = loadedState.details;
        final theme = Theme.of(context);

        return Stack(
          fit: StackFit.expand,
          children: [
            AppNetworkImage(imageUrl: details.thumbnailUrl, fit: BoxFit.cover),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.78),
                  ],
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
                          imageUrl: details.channelImageUrl,
                          radius: 30.r,
                          fallbackText: details.title,
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                details.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                '${details.subscriptionsCount.formatCount()} ${S.current.subscribers} • ' // Reusing key from previous batches!
                                '${details.videosCount.formatCount()} ${S.current.videos} • ' // Reusing key from previous batches!
                                '${details.totalViews.formatCount()} ${S.current.views}', // Reusing key from previous batches!
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      spacing: 8.w,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (details.description != null &&
                            details.description!.isNotEmpty) ...[
                          10.verticalSpace,
                          Expanded(
                            child: Text(
                              details.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white70,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                        if (!details.isOwner) ...[
                          12.verticalSpace,
                          SubscribeButton(
                            channelId: channelId,
                            isSubscribed: details.isSubscribed,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

      case ChannelDetailsErrorState():
        final errorState = state as ChannelDetailsErrorState;
        return AppErrorWidget(
          message: errorState.message,
          onRetry: () {
            context.read<ChannelDetailsCubit>().fetchChannelDetails(channelId);
          },
          icon: Icons.wifi_off_rounded,
          iconSize: 36.r,
          iconColor: Theme.of(context).hintColor,
        );
    }
  }
}
