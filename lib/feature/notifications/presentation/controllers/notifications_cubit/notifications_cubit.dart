import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/delete_notifications_use_cases.dart';
import '../../../domain/use_cases/get_notifications_use_case.dart';
import '../../../domain/use_cases/mark_notifications_use_cases.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase;
  final MarkNotificationReadUseCase markNotificationReadUseCase;
  final DeleteAllNotificationsUseCase deleteAllNotificationsUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;

  NotificationsCubit({
    required this.getNotificationsUseCase,
    required this.markAllNotificationsReadUseCase,
    required this.markNotificationReadUseCase,
    required this.deleteAllNotificationsUseCase,
    required this.deleteNotificationUseCase,
  }) : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());

    final result = await getNotificationsUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(NotificationsError(message: failure.message)),
      (data) {
        if (data.items.isEmpty) {
          emit(NotificationsEmpty());
        } else {
          emit(NotificationsLoaded(notifications: data, isFetchingMore: false));
        }
      },
    );
  }

  Future<void> fetchMoreNotifications() async {
    final currentState = state;
    final currentNotifications = state.notifications;
    if (currentNotifications == null ||
        !currentNotifications.hasNextPage ||
        (currentState is NotificationsLoaded && currentState.isFetchingMore)) {
      return;
    }

    emit(
      NotificationsLoaded(
        notifications: currentNotifications,
        isFetchingMore: true,
      ),
    );

    final nextPage = currentNotifications.pageNumber + 1;
    final result = await getNotificationsUseCase(pageNumber: nextPage);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: currentNotifications,
        ),
      ),
      (data) => emit(
        NotificationsLoaded(
          notifications: data.copyWith(
            items: [...currentNotifications.items, ...data.items],
          ),
          isFetchingMore: false,
        ),
      ),
    );
  }

  Future<void> markAllAsRead() async {
    final currentNotifications = state.notifications;

    if (currentNotifications == null) return;

    final updatedItems = currentNotifications.items
        .map((item) => item.copyWith(isRead: true))
        .toList();

    emit(
      NotificationsLoaded(
        notifications: currentNotifications.copyWith(
          items: updatedItems,
          unreadTotal: 0,
        ),
      ),
    );

    final result = await markAllNotificationsReadUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: currentNotifications,
        ),
      ),
      (_) {},
    );
  }

  Future<void> markAsRead(String id) async {
    final currentNotifications = state.notifications;
    if (currentNotifications == null) return;
    bool readBefore = false;

    final updatedItems = currentNotifications.items.map((item) {
      if (item.notificationId == id) {
        readBefore = item.isRead;
        return item.copyWith(isRead: true);
      }
      return item;
    }).toList();

    if (readBefore) return;

    emit(
      NotificationsLoaded(
        notifications: currentNotifications.copyWith(
          items: updatedItems,
          unreadTotal: currentNotifications.unreadTotal - 1,
        ),
      ),
    );

    final result = await markNotificationReadUseCase(id);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: currentNotifications,
        ),
      ),
      (_) {},
    );
  }

  Future<void> deleteAll() async {
    final currentNotifications = state.notifications;
    if (currentNotifications == null) return;

    emit(NotificationsEmpty());

    final result = await deleteAllNotificationsUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: currentNotifications,
        ),
      ),
      (_) {},
    );
  }

  Future<void> deleteNotification(String id) async {
    final currentNotifications = state.notifications;
    if (currentNotifications == null) return;

    final updatedItems = currentNotifications.items
        .where((item) => item.notificationId != id)
        .toList();

    if (updatedItems.isEmpty) {
      emit(NotificationsEmpty());
    } else {
      emit(
        NotificationsLoaded(
          notifications: currentNotifications.copyWith(
            items: updatedItems,
            totalCount: currentNotifications.totalCount - 1,
          ),
        ),
      );
    }

    final result = await deleteNotificationUseCase(id);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: currentNotifications,
        ),
      ),
      (_) {},
    );
  }
}
