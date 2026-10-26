import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_cubit.dart';
import 'package:stream_pro/feature/library/presentation/widgets/history_section.dart';
import 'package:stream_pro/feature/library/presentation/widgets/liked_section.dart';
import 'package:stream_pro/feature/library/presentation/widgets/watch_later_section.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_cubit.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_cubit/watch_later_cubit.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  static const int _previewCount = 10;

  Future<void> _refreshAll(BuildContext context) {
    return Future.wait([
      context.read<WatchHistoryCubit>().fetchWatchHistory(),
      context.read<WatchLaterCubit>().fetchWatchLater(),
      context.read<LikedVideosCubit>().fetchLikedVideos(),
    ]);
  }

  Future<void> _openVideo(BuildContext context, VideoCardData video) async {
    await context.navigateTo(
      AppRoutes.videoDetails,
      arguments: VideoDetailsArgs(video.id),
    );
  }

  Future<void> _openHistory(BuildContext context) async {
    await context.navigateTo(AppRoutes.watchHistory);
  }

  Future<void> _openWatchLater(BuildContext context) async {
    await context.navigateTo(AppRoutes.watchLater);
  }

  Future<void> _openLiked(BuildContext context) async {
    await context.navigateTo(AppRoutes.likedVideo);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppRefreshIndicator(
      onRefresh: () => _refreshAll(context),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 8.h, bottom: 32.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Library',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 20.h),
            child: Text(
              'Everything you watched, saved and loved',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: appTheme.textSecondary),
            ),
          ),
          HistorySection(
            previewCount: _previewCount,
            onVideoTap: (v) => _openVideo(context, v),
            onSeeAll: () => _openHistory(context),
          ),
          28.verticalSpace,
          WatchLaterSection(
            previewCount: _previewCount,
            onVideoTap: (v) => _openVideo(context, v),
            onSeeAll: () => _openWatchLater(context),
          ),
          28.verticalSpace,
          LikedSection(
            previewCount: _previewCount,
            onVideoTap: (v) => _openVideo(context, v),
            onSeeAll: () => _openLiked(context),
          ),
        ],
      ),
    );
  }
}
