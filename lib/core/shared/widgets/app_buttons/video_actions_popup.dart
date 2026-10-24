import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_selector_sheet.dart';

enum VideoAction { saveToPlaylist, watchLater, share }

class VideoActionsPopup extends StatelessWidget {
  final String videoId;

  const VideoActionsPopup({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<VideoAction>(
      trigger: _Trigger(),
      menuWidth: 180.w,
      items: const [
        AppMenuItem(
          value: VideoAction.saveToPlaylist,
          title: 'Save to playlist',
          icon: Icons.playlist_add_outlined,
        ),
        AppMenuItem(
          value: VideoAction.watchLater,
          title: 'Watch later',
          icon: Icons.schedule_outlined,
        ),
        AppMenuItem(
          value: VideoAction.share,
          title: 'Share',
          icon: Icons.share_outlined,
        ),
      ],
      onSelected: (action) => _handleAction(context, action),
    );
  }

  void _handleAction(BuildContext context, VideoAction action) {
    switch (action) {
      case VideoAction.saveToPlaylist:
        PlaylistSelectorSheet.show(context, videoId: videoId);
        break;
      case VideoAction.watchLater:
        context.showSuccessSnackBar(message: 'Watch later is coming soon.');
        break;
      case VideoAction.share:
        context.showSuccessSnackBar(message: 'Share is coming soon.');
        break;
    }
  }
}

class _Trigger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        shape: BoxShape.circle,
        border: Border.all(color: appTheme.grey600.withValues(alpha: 0.4)),
      ),
      child: Icon(Icons.more_vert, size: 16.r, color: Colors.white),
    );
  }
}
