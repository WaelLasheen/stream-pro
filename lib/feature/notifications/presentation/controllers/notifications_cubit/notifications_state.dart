import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_notifications_entity.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final PaginatedNotificationsEntity notifications;
  final bool isFetchingMore;

  const NotificationsLoaded({
    required this.notifications,
    this.isFetchingMore = false,
  });

  NotificationsLoaded copyWith({
    PaginatedNotificationsEntity? notifications,
    bool? isFetchingMore,
  }) {
    return NotificationsLoaded(
      notifications: notifications ?? this.notifications,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  @override
  List<Object?> get props => [notifications, isFetchingMore];
}

class NotificationsEmpty extends NotificationsState {}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}