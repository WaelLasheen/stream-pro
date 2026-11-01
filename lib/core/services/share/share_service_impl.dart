import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stream_pro/core/services/share/share_service.dart';
import 'package:stream_pro/core/utils/consts/app_urls.dart';

class ShareServiceImpl implements ShareService {
  const ShareServiceImpl();

  @override
  Future<void> shareVideo(
    BuildContext context, {
    required String videoId,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    final screenSize = MediaQuery.sizeOf(context);

    final origin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : Rect.fromCenter(
            center: screenSize.center(Offset.zero),
            width: 1,
            height: 1,
          );

    await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse(AppUrls.video(videoId)),
        sharePositionOrigin: origin,
      ),
    );
  }
}
