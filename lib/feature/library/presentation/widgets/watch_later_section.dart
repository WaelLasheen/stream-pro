import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_section.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_empty_card.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_error_card.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_rail.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_rail_shimmer.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_cubit.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_state.dart';
import 'package:stream_pro/feature/watch_later/presentation/mapper/watch_later_mapper.dart';
import 'package:stream_pro/generated/l10n.dart';

class WatchLaterSection extends StatelessWidget {
  final int previewCount;
  final ValueChanged<VideoCardData> onVideoTap;
  final VoidCallback onSeeAll;

  const WatchLaterSection({
    super.key,
    required this.previewCount,
    required this.onVideoTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocBuilder<WatchLaterCubit, WatchLaterState>(
      builder: (context, state) {
        int? count;
        final Widget content;

        switch (state) {
          case WatchLaterInitial() || WatchLaterLoading():
            content = const LibraryRailShimmer(key: ValueKey('loading'));
          case WatchLaterEmpty():
            content = LibraryEmptyCard(
              key: ValueKey('empty'),
              icon: Icons.watch_later_outlined,
              message: S.current.watchLaterEmptyMessage,
            );
          case WatchLaterError():
            content = LibraryErrorCard(
              key: const ValueKey('error'),
              message: state.message,
              onRetry: () => context.read<WatchLaterCubit>().fetchWatchLater(),
            );
          case WatchLaterLoaded():
            count = state.feed.videoCount;
            content = LibraryRail(
              key: const ValueKey('loaded'),
              videos: state.feed.items
                  .take(previewCount)
                  .map((e) => e.toVideoCardData())
                  .toList(),
              onVideoTap: onVideoTap,
              onSeeAll: onSeeAll,
            );
        }

        return LibrarySection(
          icon: Icons.watch_later_rounded,
          accent: appTheme.warningColor,
          title: S.current.watchLater,
          count: count,
          onSeeAll: onSeeAll,
          child: content,
        );
      },
    );
  }
}
