import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/video_actions_popup.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_cubit.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_state.dart';
import 'package:stream_pro/feature/watch_later/presentation/mapper/watch_later_mapper.dart';

class WatchLaterScreen extends StatelessWidget {
  const WatchLaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch Later'), centerTitle: true),
      body: BlocBuilder<WatchLaterCubit, WatchLaterState>(
        builder: (context, state) {
          switch (state) {
            case WatchLaterInitial():
            case WatchLaterLoading():
              return ShimmerList(
                itemBuilder: (_, __) => const VideoCardShimmer(
                  variant: VideoCardVariant.horizontal,
                ),
                itemCount: 5,
              );

            case WatchLaterError():
              return AppErrorWidget(
                message: state.message,
                retryIcon: Icons.refresh,
                onRetry: () =>
                    context.read<WatchLaterCubit>().fetchWatchLater(),
              );

            case WatchLaterEmpty():
              return const AppEmptyWidget(
                icon: Icons.watch_later_outlined,
                message: 'Videos you save for later will appear here.',
              );

            case WatchLaterLoaded():
              final items = state.feed.items;

              return AppRefreshIndicator(
                onRefresh: () =>
                    context.read<WatchLaterCubit>().fetchWatchLater(),
                child: ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return VideoCardWidget(
                      video: item.toVideoCardData(),
                      variant: VideoCardVariant.horizontal,
                      onTap: () async {
                        await context.navigateTo(
                          AppRoutes.videoDetails,
                          arguments: VideoDetailsArgs(item.video.id),
                        );
                        if (!context.mounted) return;
                        context.read<WatchLaterCubit>().fetchWatchLater(
                          showLoading: false,
                        );
                      },
                      onChannelTap: () => context.navigateTo(
                        AppRoutes.channelDetails,
                        arguments: item.video.channel.id,
                      ),
                      watchLaterAction: WatchLaterCardAction.remove,
                      onWatchLaterToggled: (isInWatchLater) {
                        if (!isInWatchLater) {
                          context.read<WatchLaterCubit>().removeLocally(
                            item.video.id,
                          );
                        }
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
