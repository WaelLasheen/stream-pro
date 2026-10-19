import '../../domain/entities/notification_item_entity.dart';
import '../../domain/entities/notification_type_enum.dart';

class NotificationItemModel {
  final String notificationId;
  final String actorId;
  final String recipientId;
  final String videoId;
  final String commentId;
  final String channelId;
  final String playlistId;
  final String message;
  final NotificationType type;
  final bool isRead;
  final String createdAt;

  const NotificationItemModel({
    required this.notificationId,
    required this.actorId,
    required this.recipientId,
    required this.videoId,
    required this.commentId,
    required this.channelId,
    required this.playlistId,
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
      videoId: json['videoId'] as String? ?? '',
      commentId: json['commentId'] as String? ?? '',
      channelId: json['channelId'] as String? ?? '',
      playlistId: json['playlistId'] as String? ?? '',
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
      videoId: videoId,
      commentId: commentId,
      channelId: channelId,
      playlistId: playlistId,
      message: message,
      type: type,
      isRead: isRead,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    );
  }
}
