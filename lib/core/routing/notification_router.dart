import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';

class NotificationRouter {
  static void handleNotificationTap(Map<String, dynamic> data) {
    AppDebuggingPrint.printDebug('🚀 Processing Notification Data: $data');

    final String? type = data['type'] as String?;
    if (type == null) return;

    switch (type) {
      // case 'live_stream':
      //   final String? streamId = data['stream_id'] as String?;
      //   if (streamId != null) {
      //     navigatorKey.currentState?.pushNamed(
      //       AppRoutes.liveStream,
      //       arguments: streamId,
      //     );
      //   }
      //   break;

      // case 'video_upload':
      //   final String? videoId = data['video_id'] as String?;
      //   if (videoId != null) {
      //     navigatorKey.currentState?.pushNamed(
      //       AppRoutes.videoDetails,
      //       arguments: videoId,
      //     );
      //   }
      //   break;
    }
  }
}