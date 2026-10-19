import 'package:equatable/equatable.dart';
import 'notification_type_enum.dart';

class NotificationItemEntity extends Equatable {
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
  final DateTime createdAt;

  const NotificationItemEntity({
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

  NotificationItemEntity copyWith({
    String? notificationId,
    String? actorId,
    String? recipientId,
    String? videoId,
    String? commentId,
    String? channelId,
    String? playlistId,
    String? message,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationItemEntity(
      notificationId: notificationId ?? this.notificationId,
      actorId: actorId ?? this.actorId,
      recipientId: recipientId ?? this.recipientId,
      videoId: videoId ?? this.videoId,
      commentId: commentId ?? this.commentId,
      channelId: channelId ?? this.channelId,
      playlistId: playlistId ?? this.playlistId,
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
    videoId,
    commentId,
    channelId,
    playlistId,
    message,
    type,
    isRead,
    createdAt,
  ];
}
