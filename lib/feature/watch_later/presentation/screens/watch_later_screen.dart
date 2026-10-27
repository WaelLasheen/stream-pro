import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/video_actions_popup.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/load_more_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
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
          final items = state.feed?.items ?? [];
          final isInitialLoading =
              state is WatchLaterInitial || state is WatchLaterLoading;
          final initialError = state is WatchLaterError && items.isEmpty;
          final loadMoreError = state is WatchLaterError && items.isNotEmpty;
          final isLoadingMore =
              state is WatchLaterLoaded && state.isLoadingMore;

          if (isInitialLoading) {
            return ShimmerList(
              itemBuilder: (_, __) =>
                  const VideoCardShimmer(variant: VideoCardVariant.horizontal),
              itemCount: 10,
            );
          }
          if (initialError) {
            return AppErrorWidget(
              message: state.message,
              retryIcon: Icons.refresh,
              onRetry: () => context.read<WatchLaterCubit>().fetchWatchLater(),
            );
          }
          if (state is WatchLaterEmpty) {
            return const AppEmptyWidget(
              icon: Icons.watch_later_outlined,
              message: 'Videos you save for later will appear here.',
            );
          }
          return AppRefreshIndicator(
            onRefresh: () => context.read<WatchLaterCubit>().fetchWatchLater(),
            child: LoadMoreListener(
              onLoadMore: () {
                if (state is WatchLaterLoaded) {
                  context.read<WatchLaterCubit>().fetchMore();
                }
              },
              child: ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount:
                    items.length + (loadMoreError || isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= items.length) {
                    if (loadMoreError) {
                      return LoadMoreErrorWidget(
                        message: state.message,
                        onRetry: () =>
                            context.read<WatchLaterCubit>().fetchMore(),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }

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
            ),
          );
        },
      ),
    );
  }
}
