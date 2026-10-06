import '../../domain/entities/notification_item_entity.dart';
import '../../domain/entities/notification_type_enum.dart';

class NotificationItemModel {
  final String notificationId;
  final String actorId;
  final String recipientId;
  final String contextId;
  final String message;
  final NotificationType type;
  final bool isRead;
  final String createdAt;

  const NotificationItemModel({
    required this.notificationId,
    required this.actorId,
    required this.recipientId,
    required this.contextId,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      notificationId: json['notificationId'] as String? ?? '',
      actorId: json['actorId'] as String? ?? '',
      recipientId: json['recipientId'] as String? ?? '',
      contextId: json['contextId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      type: NotificationType.fromString(json['type'] as String?),
      isRead: json['isRead'] as bool? ?? false,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  NotificationItemEntity toEntity() {
    return NotificationItemEntity(
      notificationId: notificationId,
      actorId: actorId,
      recipientId: recipientId,
      contextId: contextId,
      message: message,
      type: type,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}
