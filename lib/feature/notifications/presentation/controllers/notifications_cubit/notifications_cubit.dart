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

  int _currentPage = 1;
  bool _hasNextPage = false;
  bool _isFetchingMore = false;

  NotificationsCubit({
    required this.getNotificationsUseCase,
    required this.markAllNotificationsReadUseCase,
    required this.markNotificationReadUseCase,
    required this.deleteAllNotificationsUseCase,
    required this.deleteNotificationUseCase,
  }) : super(NotificationsInitial());

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    _currentPage = 1;
    _hasNextPage = false;
    _isFetchingMore = false;

    if (!isRefresh) emit(NotificationsLoading());

    final result = await getNotificationsUseCase(
      pageNumber: _currentPage,
      pageSize: 10,
    );

    result.fold(
      (failure) {
        if (!isRefresh) emit(NotificationsError(failure.message));
      },
      (data) {
        _hasNextPage = data.hasNextPage;
        if (data.items.isEmpty) {
          emit(NotificationsEmpty());
        } else {
          emit(NotificationsLoaded(
            notifications: data,
            isFetchingMore: false,
          ));
        }
      },
    );
  }

  Future<void> fetchMoreNotifications() async {
    if (_isFetchingMore || !_hasNextPage) return;
    if (state is! NotificationsLoaded) return;

    final currentState = state as NotificationsLoaded;
    _isFetchingMore = true;

    emit(currentState.copyWith(isFetchingMore: true));

    final nextPage = _currentPage + 1;
    final result = await getNotificationsUseCase(
      pageNumber: nextPage,
      pageSize: 10,
    );

    result.fold(
      (failure) {
        _isFetchingMore = false;
        emit(currentState.copyWith(isFetchingMore: false));
      },
      (data) {
        _currentPage = nextPage;
        _hasNextPage = data.hasNextPage;
        _isFetchingMore = false;

        final combinedItems = List.of(currentState.notifications.items)
          ..addAll(data.items);

        final updatedPaginatedEntity = data.copyWith(items: combinedItems);

        emit(NotificationsLoaded(
          notifications: updatedPaginatedEntity,
          isFetchingMore: false,
        ));
      },
    );
  }

  Future<void> markAllAsRead() async {
    if (state is! NotificationsLoaded) return;
    final currentState = state as NotificationsLoaded;

    final updatedItems = currentState.notifications.items
        .map((item) => item.copyWith(isRead: true))
        .toList();

    emit(currentState.copyWith(
      notifications: currentState.notifications.copyWith(
        items: updatedItems,
        unreadTotal: 0,
      ),
    ));

    final result = await markAllNotificationsReadUseCase();
    result.fold(
      (failure) => fetchNotifications(isRefresh: true),
      (_) {},
    );
  }

  Future<void> markAsRead(String id) async {
    if (state is! NotificationsLoaded) return;
    final currentState = state as NotificationsLoaded;

    final targetIndex = currentState.notifications.items
        .indexWhere((item) => item.notificationId == id);
    if (targetIndex == -1) return;

    final targetItem = currentState.notifications.items[targetIndex];
    if (targetItem.isRead) return;

    final updatedItems = List.of(currentState.notifications.items);
    updatedItems[targetIndex] = targetItem.copyWith(isRead: true);

    final newUnreadTotal =
        (currentState.notifications.unreadTotal - 1).clamp(0, 999);

    emit(currentState.copyWith(
      notifications: currentState.notifications.copyWith(
        items: updatedItems,
        unreadTotal: newUnreadTotal,
      ),
    ));

    final result = await markNotificationReadUseCase(id);
    result.fold(
      (failure) => fetchNotifications(isRefresh: true),
      (_) {},
    );
  }

  Future<void> deleteAll() async {
    emit(NotificationsEmpty());

    final result = await deleteAllNotificationsUseCase();
    result.fold(
      (failure) => fetchNotifications(isRefresh: true),
      (_) {},
    );
  }

  Future<void> deleteNotification(String id) async {
    if (state is! NotificationsLoaded) return;
    final currentState = state as NotificationsLoaded;

    final updatedItems = currentState.notifications.items
        .where((item) => item.notificationId != id)
        .toList();

    if (updatedItems.isEmpty) {
      emit(NotificationsEmpty());
    } else {
      emit(currentState.copyWith(
        notifications: currentState.notifications.copyWith(
          items: updatedItems,
          totalCount: currentState.notifications.totalCount - 1,
        ),
      ));
    }

    final result = await deleteNotificationUseCase(id);
    result.fold(
      (failure) => fetchNotifications(isRefresh: true),
      (_) {},
    );
  }
}