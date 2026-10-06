import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../domain/entities/notification_item_entity.dart';
import '../../domain/entities/notification_type_enum.dart';
import '../controllers/notifications_cubit/notifications_cubit.dart';
import '../controllers/notifications_cubit/notifications_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Icons.favorite;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.playlist:
        return Icons.playlist_play;
      case NotificationType.subscription:
        return Icons.subscriptions;
      case NotificationType.unknown:
        return Icons.notifications;
    }
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Colors.redAccent;
      case NotificationType.comment:
        return Colors.blue;
      case NotificationType.playlist:
        return Colors.teal;
      case NotificationType.subscription:
        return Colors.deepPurple;
      case NotificationType.unknown:
        return Colors.orange;
    }
  }

  void _onNotificationTap(BuildContext context, NotificationItemEntity item) {
    context.read<NotificationsCubit>().markAsRead(item.notificationId);

    if (item.contextId.isNotEmpty) {
      switch (item.type) {
        case NotificationType.subscription:
          Navigator.pushNamed(
            context,
            AppRoutes.channelDetails,
            arguments: item.contextId,
          );
          break;
        case NotificationType.like:
        case NotificationType.comment:
        case NotificationType.playlist:
        case NotificationType.unknown:
          Navigator.pushNamed(
            context,
            AppRoutes.videoDetails,
            arguments: item.contextId,
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: FontStyles.titleLarge),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'mark_all') {
                context.read<NotificationsCubit>().markAllAsRead();
              } else if (value == 'clear_all') {
                context.read<NotificationsCubit>().deleteAll();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear all notifications'),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<NotificationsCubit>().fetchNotifications(
          isRefresh: true,
        ),
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: FontStyles.bodyMedium),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      onPressed: () => context
                          .read<NotificationsCubit>()
                          .fetchNotifications(isRefresh: false),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is NotificationsEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 64.sp,
                      color: theme.disabledColor,
                    ),
                    SizedBox(height: 12.h),
                    Text('No notifications yet', style: FontStyles.bodyLarge),
                  ],
                ),
              );
            }

            if (state is NotificationsLoaded) {
              final items = state.notifications.items;
              final isFetchingMore = state.isFetchingMore;

              return LoadMoreListener(
                onLoadMore: () {
                  context.read<NotificationsCubit>().fetchMoreNotifications();
                },
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: items.length + (isFetchingMore ? 1 : 0),
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    final item = items[index];
                    final createdAtDate =
                        DateTime.tryParse(item.createdAt) ?? DateTime.now();

                    return Dismissible(
                      key: Key(item.notificationId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.w),
                        color: Colors.redAccent,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        context.read<NotificationsCubit>().deleteNotification(
                          item.notificationId,
                        );
                      },
                      child: Container(
                        color: item.isRead
                            ? Colors.transparent
                            : theme.primaryColor.withValues(alpha: 0.06),
                        child: ListTile(
                          onTap: () => _onNotificationTap(context, item),
                          leading: CircleAvatar(
                            backgroundColor: _getTypeColor(
                              item.type,
                            ).withValues(alpha: 0.15),
                            child: Icon(
                              _getTypeIcon(item.type),
                              color: _getTypeColor(item.type),
                              size: 20.sp,
                            ),
                          ),
                          title: Text(
                            item.message,
                            style: FontStyles.bodyMedium.copyWith(
                              fontWeight: item.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              timeago.format(createdAtDate),
                              style: FontStyles.bodySmall.copyWith(
                                color: theme.hintColor,
                              ),
                            ),
                          ),
                          trailing: !item.isRead
                              ? Container(
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
