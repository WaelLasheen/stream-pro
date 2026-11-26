import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/routing/notification_destination.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/generated/l10n.dart';
import '../../domain/entities/notification_item_entity.dart';
import '../controllers/notifications_cubit/notifications_cubit.dart';
import '../controllers/notifications_cubit/notifications_state.dart';
import '../widgets/notification_app_bar_actions.dart';
import '../widgets/notification_list_view.dart';
import '../widgets/notification_loading_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  void _onNotificationTap(BuildContext context, NotificationItemEntity item) {
    context.read<NotificationsCubit>().markAsRead(item.notificationId);

    final destination = resolveNotificationDestination(
      type: item.type,
      videoId: item.videoId,
      playlistId: item.playlistId,
    );

    if (destination == null) return;

    context.navigateTo(destination.route, arguments: destination.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.notifications, style: FontStyles.titleLarge),
        actions: const [NotificationAppBarActions()],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          switch (state) {
            case NotificationsInitial():
            case NotificationsLoading():
              return const NotificationLoadingView();

            case NotificationsEmpty():
              return AppEmptyWidget(
                icon: Icons.notifications_off_outlined,
                message: S.current.noNotificationsYet,
              );

            case NotificationsLoaded():
              final items =
                  state.notifications?.items ??
                  const <NotificationItemEntity>[];

              return NotificationListView(
                items: items,
                isLoadingMore: state.isFetchingMore,
                onLoadMore: () =>
                    context.read<NotificationsCubit>().fetchMoreNotifications(),
                onRefresh: () =>
                    context.read<NotificationsCubit>().fetchNotifications(),
                onTap: (item) => _onNotificationTap(context, item),
                onDismissed: (item) => context
                    .read<NotificationsCubit>()
                    .deleteNotification(item.notificationId),
              );

            case NotificationsError():
              final items =
                  state.notifications?.items ??
                  const <NotificationItemEntity>[];
              if (items.isEmpty) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () =>
                      context.read<NotificationsCubit>().fetchNotifications(),
                  icon: Icons.wifi_off_rounded,
                  retryIcon: Icons.refresh,
                );
              }

              return NotificationListView(
                items: items,
                loadMoreError: state.message,
                onRetryLoadMore: () =>
                    context.read<NotificationsCubit>().fetchMoreNotifications(),
                onRefresh: () =>
                    context.read<NotificationsCubit>().fetchNotifications(),
                onTap: (item) => _onNotificationTap(context, item),
                onDismissed: (item) => context
                    .read<NotificationsCubit>()
                    .deleteNotification(item.notificationId),
              );
          }
        },
      ),
    );
  }
}
