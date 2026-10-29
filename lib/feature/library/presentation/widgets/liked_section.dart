import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_cubit.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_state.dart';
import 'package:stream_pro/feature/Likes/presentation/mapper/liked_video_mapper.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_section.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_empty_card.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_error_card.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_rail.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_rail_shimmer.dart';
import 'package:stream_pro/generated/l10n.dart';

class LikedSection extends StatelessWidget {
  final int previewCount;
  final ValueChanged<VideoCardData> onVideoTap;
  final VoidCallback onSeeAll;

  const LikedSection({
    super.key,
    required this.previewCount,
    required this.onVideoTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocBuilder<LikedVideosCubit, LikedVideosState>(
      builder: (context, state) {
        int? count;
        final Widget content;

        switch (state) {
          case LikedVideosInitial() || LikedVideosLoading():
            content = const LibraryRailShimmer(key: ValueKey('loading'));
          case LikedVideosError():
            content = LibraryErrorCard(
              key: const ValueKey('error'),
              message: state.message,
              onRetry: () =>
                  context.read<LikedVideosCubit>().fetchLikedVideos(),
            );
          case LikedVideosLoaded():
            final items = state.feed.items;
            count = state.feed.videoCount;
            content = items.isEmpty
                ? LibraryEmptyCard(
                    key: ValueKey('empty'),
                    icon: Icons.favorite_border_rounded,
                    message: S.current.youHaventLikedAnyVideosYet,
                  )
                : LibraryRail(
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
          icon: Icons.favorite_rounded,
          accent: appTheme.redNormalColor,
          title: S.current.likedVideos,
          count: count,
          onSeeAll: onSeeAll,
          child: content,
        );
      },
    );
  }
}
