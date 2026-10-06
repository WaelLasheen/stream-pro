import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import '../../domain/entities/watch_history_group_entity.dart';
import '../controllers/watch_history_cubit/watch_history_cubit.dart';
import '../controllers/watch_history_cubit/watch_history_state.dart';

class WatchHistoryScreen extends StatelessWidget {
  const WatchHistoryScreen({super.key});

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> _openVideo(BuildContext context, String videoId) async {
    // Navigate to video details screen
    await Navigator.pushNamed(
      context,
      AppRoutes.videoDetails,
      arguments: videoId,
    );

    // When returning from the video screen, silently refresh watch history without showing loader
    if (context.mounted) {
      context.read<WatchHistoryCubit>().fetchWatchHistory(silent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () =>
          context.read<WatchHistoryCubit>().fetchWatchHistory(silent: false),
      child: BlocBuilder<WatchHistoryCubit, WatchHistoryState>(
        builder: (context, state) {
          if (state is WatchHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WatchHistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: FontStyles.bodyMedium),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => context
                        .read<WatchHistoryCubit>()
                        .fetchWatchHistory(silent: false),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is WatchHistoryEmpty) {
            return Center(
              child: Text(
                'No watch history found',
                style: FontStyles.bodyLarge,
              ),
            );
          }

          if (state is WatchHistoryLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                final group = state.groups[index];
                return _buildGroupSection(context, theme, group);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildGroupSection(
    BuildContext context,
    ThemeData theme,
    WatchHistoryGroupEntity group,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            group.label,
            style: FontStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        ...group.items.map((item) => _buildHistoryItem(context, theme, item)),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    ThemeData theme,
    WatchHistoryItemEntity item,
  ) {
    return InkWell(
      onTap: () => _openVideo(context, item.video.id),
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail & Progress Bar
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: item.video.thumbnailUrl ?? '',
                    width: 120.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: Colors.grey.shade300),
                    errorWidget: (_, __, ___) => Container(
                      width: 120.w,
                      height: 70.h,
                      color: Colors.grey.shade400,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4.h,
                  right: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      _formatDuration(item.video.durationSeconds),
                      style: FontStyles.labelSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Progress indicator line at the bottom of the thumbnail
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8.r),
                    ),
                    child: LinearProgressIndicator(
                      value: item.completionRate.clamp(0.0, 1.0),
                      minHeight: 3.h,
                      backgroundColor: Colors.white30,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),

            // Video & Channel Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.titleSmall,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.channel.title,
                    style: FontStyles.bodySmall.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${_formatDuration(item.watchedSeconds)} watched',
                    style: FontStyles.labelSmall.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
