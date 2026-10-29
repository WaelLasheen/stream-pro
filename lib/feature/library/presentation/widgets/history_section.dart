import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_section.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_empty_card.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_error_card.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_rail.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_rail_shimmer.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_cubit.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_state.dart';
import 'package:stream_pro/feature/watch_history/presentation/mapper/watch_history_item_mapper.dart';
import 'package:stream_pro/generated/l10n.dart';

class HistorySection extends StatelessWidget {
  final int previewCount;
  final ValueChanged<VideoCardData> onVideoTap;
  final VoidCallback onSeeAll;

  const HistorySection({
    super.key,
    required this.previewCount,
    required this.onVideoTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocBuilder<WatchHistoryCubit, WatchHistoryState>(
      builder: (context, state) {
        int? count;
        final Widget content;

        switch (state) {
          case WatchHistoryInitial() || WatchHistoryLoading():
            content = const LibraryRailShimmer(key: ValueKey('loading'));
          case WatchHistoryEmpty():
            content = LibraryEmptyCard(
              key: const ValueKey('empty'),
              icon: Icons.history_toggle_off_rounded,
              message: S.current.historyEmptyMessage,
            );
          case WatchHistoryError():
            content = LibraryErrorCard(
              key: const ValueKey('error'),
              message: state.message,
              onRetry: () =>
                  context.read<WatchHistoryCubit>().fetchWatchHistory(),
            );
          case WatchHistoryLoaded():
            final items = state.groups.expand((g) => g.items).toList();
            count = items.length;
            content = LibraryRail(
              key: const ValueKey('loaded'),
              videos: items
                  .take(previewCount)
                  .map((e) => e.toVideoCardData())
                  .toList(),
              onVideoTap: onVideoTap,
              onSeeAll: onSeeAll,
            );
        }

        return LibrarySection(
          icon: Icons.history_rounded,
          accent: appTheme.primaryColor,
          title: S.current.history,
          count: count,
          onSeeAll: onSeeAll,
          child: content,
        );
      },
    );
  }
}
