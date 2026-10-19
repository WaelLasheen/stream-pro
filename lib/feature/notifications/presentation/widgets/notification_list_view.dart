import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/load_more_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import '../../domain/entities/notification_item_entity.dart';
import 'notification_item_widget.dart';

class NotificationListView extends StatelessWidget {
  final List<NotificationItemEntity> items;
  final bool isLoadingMore;
  final String? loadMoreError;
  final Future<void> Function() onRefresh;
  final ValueChanged<NotificationItemEntity> onTap;
  final ValueChanged<NotificationItemEntity> onDismissed;
  final VoidCallback? onLoadMore;
  final VoidCallback? onRetryLoadMore;

  const NotificationListView({
    super.key,
    required this.items,
    required this.onRefresh,
    required this.onTap,
    required this.onDismissed,
    this.isLoadingMore = false,
    this.loadMoreError,
    this.onLoadMore,
    this.onRetryLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    final hasFooter = isLoadingMore || loadMoreError != null;

    return AppRefreshIndicator(
      onRefresh: onRefresh,
      child: LoadMoreListener(
        onLoadMore: onLoadMore,
        child: ListView.separated(
          key: const PageStorageKey<String>('notifications_list_key'),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          itemCount: items.length + (hasFooter ? 1 : 0),
          separatorBuilder: (_, _) => 8.verticalSpace,
          itemBuilder: (context, index) {
            if (index < items.length) {
              final item = items[index];
              return NotificationItemWidget(
                item: item,
                onTap: () => onTap(item),
                onDismissed: () => onDismissed(item),
              );
            }

            if (isLoadingMore) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return LoadMoreErrorWidget(
              message: loadMoreError!,
              onRetry: onRetryLoadMore,
            );
          },
        ),
      ),
    );
  }
}
