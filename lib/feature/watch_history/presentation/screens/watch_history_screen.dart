import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
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
      arguments: videoId,
    );

    if (context.mounted) {
      context.read<WatchHistoryCubit>().fetchWatchHistory(silent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      onRefresh: () => context.read<WatchHistoryCubit>().fetchWatchHistory(),
      child: BlocBuilder<WatchHistoryCubit, WatchHistoryState>(
        builder: (context, state) {
          return switch (state) {
            WatchHistoryInitial() ||
            WatchHistoryLoading() => const WatchHistoryLoadingWidget(),
            WatchHistoryEmpty() => const WatchHistoryEmptyWidget(),
            WatchHistoryError() => WatchHistoryErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<WatchHistoryCubit>().fetchWatchHistory(),
            ),
            WatchHistoryLoaded() => WatchHistoryLoadedWidget(
              groups: state.groups,
              onVideoTap: _openVideo,
            ),
          };
        },
      ),
    );
  }
}
