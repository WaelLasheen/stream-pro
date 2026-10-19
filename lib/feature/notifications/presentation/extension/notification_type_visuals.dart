import 'package:flutter/material.dart';
import '../../domain/entities/notification_type_enum.dart';

extension NotificationTypeVisuals on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.like:
        return Icons.favorite;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.reply:
        return Icons.reply;
      case NotificationType.playlist:
        return Icons.playlist_play;
      case NotificationType.subscription:
        return Icons.subscriptions;
      case NotificationType.unknown:
        return Icons.notifications;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.like:
        return Colors.redAccent;
      case NotificationType.comment:
        return Colors.blue;
      case NotificationType.reply:
        return Colors.lightBlue;
      case NotificationType.playlist:
        return Colors.teal;
      case NotificationType.subscription:
        return Colors.deepPurple;
      case NotificationType.unknown:
        return Colors.orange;
    }
  }
}
