import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/load_more_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/watch_history/presentation/mapper/watch_history_item_mapper.dart';
import '../../domain/entities/watch_history_entity.dart';
import '../../domain/entities/watch_history_item_entity.dart';

class WatchHistoryLoadedWidget extends StatelessWidget {
  final List<WatchHistoryEntity> groups;
  final Future<void> Function(BuildContext, String) onVideoTap;
  final bool isLoadingMore;
  final String? loadMoreError;
  final VoidCallback? onLoadMore;
  final VoidCallback? onLoadMoreError;

  const WatchHistoryLoadedWidget({
    super.key,
    required this.groups,
    required this.onVideoTap,
    this.isLoadingMore = false,
    this.loadMoreError,
    this.onLoadMore,
    this.onLoadMoreError,
  });

  @override
  Widget build(BuildContext context) {
    final showFooter = isLoadingMore || loadMoreError != null;

    return LoadMoreListener(
      onLoadMore: onLoadMore,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        itemCount: groups.length + (showFooter ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= groups.length) {
            if (isLoadingMore) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return LoadMoreErrorWidget(
              message: loadMoreError!,
              onRetry: onLoadMoreError,
            );
          }

          return _GroupSection(group: groups[index], onVideoTap: onVideoTap);
        },
      ),
    );
  }
}

class _GroupSection extends StatelessWidget {
  final WatchHistoryEntity group;
  final Future<void> Function(BuildContext, String) onVideoTap;

  const _GroupSection({required this.group, required this.onVideoTap});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            group.label,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: appTheme.primaryColor,
            ),
          ),
        ),
        ...group.items.map(
          (item) => _HistoryItem(item: item, onVideoTap: onVideoTap),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final WatchHistoryItemEntity item;
  final Future<void> Function(BuildContext, String) onVideoTap;

  const _HistoryItem({required this.item, required this.onVideoTap});

  @override
  Widget build(BuildContext context) {
    final videoData = item.toVideoCardData();

    return VideoCardWidget(
      video: videoData,
      variant: VideoCardVariant.horizontal,
      thumbnailWidth: 120.w,
      thumbnailHeight: 70.h,
      onTap: () => onVideoTap(context, item.video.id),
    );
  }
}
