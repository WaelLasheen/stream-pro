import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_cubit.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_state.dart';
import 'package:stream_pro/feature/watch_history/presentation/widgets/watch_history_empty_widget.dart';
import 'package:stream_pro/feature/watch_history/presentation/widgets/watch_history_error_widget.dart';
import 'package:stream_pro/feature/watch_history/presentation/widgets/watch_history_loaded_widget.dart';
import 'package:stream_pro/feature/watch_history/presentation/widgets/watch_history_loading_widget.dart';

class WatchHistoryScreen extends StatelessWidget {
  const WatchHistoryScreen({super.key});

  Future<void> _openVideo(BuildContext context, String videoId) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.videoDetails,
      arguments: VideoDetailsArgs(videoId),
    );

    if (context.mounted) {
      context.read<WatchHistoryCubit>().fetchWatchHistory(silent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch History'), centerTitle: true),
      body: AppRefreshIndicator(
        onRefresh: () => context.read<WatchHistoryCubit>().fetchWatchHistory(),
        child: BlocBuilder<WatchHistoryCubit, WatchHistoryState>(
          builder: (context, state) {
            final groups = state.groups;
            final initialLoading =
                state is WatchHistoryInitial || state is WatchHistoryLoading;
            final initialError = state is WatchHistoryError && groups.isEmpty;
            final loadMoreError =
                state is WatchHistoryError && groups.isNotEmpty;
            final isLoadingMore =
                state is WatchHistoryLoaded && state.isLoadingMore;

            if (initialLoading) {
              return const WatchHistoryLoadingWidget();
            }
            if (initialError) {
              return WatchHistoryErrorWidget(
                message: state.message,
                onRetry: () =>
                    context.read<WatchHistoryCubit>().fetchWatchHistory(),
              );
            }
            if (state is WatchHistoryEmpty) {
              return const WatchHistoryEmptyWidget();
            }

            return WatchHistoryLoadedWidget(
              groups: state.groups,
              isLoadingMore: isLoadingMore,
              loadMoreError: loadMoreError ? state.message : null,
              onLoadMore: () {
                if (state is WatchHistoryLoaded) {
                  context.read<WatchHistoryCubit>().fetchMore();
                }
              },
              onLoadMoreError: () =>
                  context.read<WatchHistoryCubit>().fetchMore(),
              onVideoTap: _openVideo,
            );
          },
        ),
      ),
    );
  }
}
