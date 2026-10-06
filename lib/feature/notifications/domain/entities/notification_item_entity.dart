import 'package:equatable/equatable.dart';
import 'notification_type_enum.dart';

class NotificationItemEntity extends Equatable {
  final String notificationId;
  final String actorId;
  final String recipientId;
  final String contextId;
  final String message;
  final NotificationType type;
  final bool isRead;
  final String createdAt;

  const NotificationItemEntity({
    required this.notificationId,
    required this.actorId,
    required this.recipientId,
    required this.contextId,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  NotificationItemEntity copyWith({
    String? notificationId,
    String? actorId,
    String? recipientId,
    String? contextId,
    String? message,
    NotificationType? type,
    bool? isRead,
    String? createdAt,
  }) {
    return NotificationItemEntity(
      notificationId: notificationId ?? this.notificationId,
      actorId: actorId ?? this.actorId,
      recipientId: recipientId ?? this.recipientId,
      contextId: contextId ?? this.contextId,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    notificationId,
    actorId,
    recipientId,
    contextId,
    message,
    type,
    isRead,
    createdAt,
  ];
}
