import 'package:flutter/material.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
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

  Color color(BuildContext context) {
    switch (this) {
      case NotificationType.like:
        return context.appTheme.errorColor;
      case NotificationType.comment:
        return context.appTheme.blueAccent;
      case NotificationType.reply:
        return context.appTheme.blueAccent;
      case NotificationType.playlist:
        return context.appTheme.tealAccent;
      case NotificationType.subscription:
        return context.appTheme.accentPurple;
      case NotificationType.unknown:
        return context.appTheme.warningColor;
    }
  }
}
