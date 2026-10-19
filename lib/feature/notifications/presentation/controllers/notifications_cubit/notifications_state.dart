import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_notifications_entity.dart';

sealed class NotificationsState extends Equatable {
  final PaginatedNotificationsEntity? notifications;

  const NotificationsState({this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final bool isFetchingMore;

  const NotificationsLoaded({
    required PaginatedNotificationsEntity super.notifications,
    this.isFetchingMore = false,
  });

  @override
  List<Object?> get props => [notifications, isFetchingMore];
}

class NotificationsEmpty extends NotificationsState {}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError({super.notifications, required this.message});

  @override
  List<Object?> get props => [notifications, message];
}
