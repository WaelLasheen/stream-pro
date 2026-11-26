import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/feature/notifications/domain/entities/notification_type_enum.dart';
import 'package:stream_pro/feature/owner_channel/presentation/args/owner_channel_args.dart';
import 'package:stream_pro/feature/playlist/presentation/args/playlist_details_args.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class NotificationDestination {
  final String route;
  final Object? arguments;

  const NotificationDestination(this.route, {this.arguments});
}

NotificationDestination? resolveNotificationDestination({
  required NotificationType type,
  String videoId = '',
  String playlistId = '',
}) {
  switch (type) {
    case NotificationType.like:
      if (videoId.isEmpty) return null;
      return NotificationDestination(
        AppRoutes.videoDetails,
        arguments: VideoDetailsArgs(videoId),
      );

    case NotificationType.comment:
    case NotificationType.reply:
      if (videoId.isEmpty) return null;
      return NotificationDestination(
        AppRoutes.videoDetails,
        arguments: VideoDetailsArgs(videoId, initialTabIndex: 1),
      );

    case NotificationType.subscription:
      return const NotificationDestination(
        AppRoutes.ownerChannel,
        arguments: OwnerChannelArgs(initialTabIndex: 2),
      );

    case NotificationType.playlist:
      if (playlistId.isEmpty) return null;
      return NotificationDestination(
        AppRoutes.playlistDetails,
        arguments: PlaylistDetailsArgs(playlistId),
      );

    case NotificationType.unknown:
      return null;
  }
}
