import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_selector_sheet.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/is_in_watch_later_use_case.dart';
import 'package:stream_pro/feature/watch_later/domain/use_cases/toggle_watch_later_use_case.dart';
import 'package:stream_pro/generated/l10n.dart';

enum VideoAction { saveToPlaylist, watchLater, share }

enum WatchLaterCardAction { add, remove }

class VideoActionsPopup extends StatelessWidget {
  final String videoId;
  final ValueChanged<bool>? onWatchLaterToggled;
  final WatchLaterCardAction watchLaterAction;

  const VideoActionsPopup({
    super.key,
    required this.videoId,
    this.onWatchLaterToggled,
    this.watchLaterAction = WatchLaterCardAction.add,
  });

  bool get _isRemoving => watchLaterAction == WatchLaterCardAction.remove;

  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<VideoAction>(
      trigger: _Trigger(),
      menuWidth: 210.w,
      items: [
        AppMenuItem(
          value: VideoAction.saveToPlaylist,
          title: S.current.saveToPlaylist,
          icon: Icons.playlist_add_outlined,
        ),
        AppMenuItem(
          value: VideoAction.watchLater,
          title: _isRemoving
              ? S.current.removeFromWatchLater
              : S.current.addToWatchLater,
          icon: _isRemoving ? Icons.watch_later : Icons.watch_later_outlined,
        ),
        AppMenuItem(
          value: VideoAction.share,
          title: S.current.share,
          icon: Icons.share_outlined,
        ),
      ],
      onSelected: (action) => _handleAction(context, action),
    );
  }

  Future<void> _handleAction(BuildContext context, VideoAction action) async {
    switch (action) {
      case VideoAction.saveToPlaylist:
        PlaylistSelectorSheet.show(context, videoId: videoId);
        break;
      case VideoAction.watchLater:
        await _handleWatchLater(context);
        break;
      case VideoAction.share:
        context.showSuccessSnackBar(message: S.current.shareComingSoon);
        break;
    }
  }

  Future<void> _handleWatchLater(BuildContext context) async {
    final desiredIsInWatchLater = !_isRemoving;
    final statusResult = await getIt<IsInWatchLaterUseCase>()(videoId: videoId);
    if (!context.mounted) return;

    final currentStatus = statusResult.fold<bool?>((failure) {
      context.showErrorSnackBar(message: failure.message);
      return null;
    }, (isInWatchLater) => isInWatchLater);

    if (currentStatus == null) return;

    if (currentStatus == desiredIsInWatchLater) {
      context.showSuccessSnackBar(
        message: desiredIsInWatchLater
            ? S.current.alreadyInWatchLater
            : S.current.alreadyRemovedFromWatchLater,
      );
      return;
    }

    final result = await getIt<ToggleWatchLaterUseCase>()(videoId: videoId);
    if (!context.mounted) return;

    result.fold(
      (failure) => context.showErrorSnackBar(message: failure.message),
      (isInWatchLater) {
        onWatchLaterToggled?.call(isInWatchLater);
        context.showSuccessSnackBar(
          message: isInWatchLater
              ? S.current.addedToWatchLater
              : S.current.removedFromWatchLater,
        );
      },
    );
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
        color: context.appTheme.textPrimary.withValues(alpha: 0.45),
        shape: BoxShape.circle,
        border: Border.all(color: appTheme.grey600.withValues(alpha: 0.4)),
      ),
      child: Icon(Icons.more_vert, size: 16.r, color: context.appTheme.surfaceColor),
    );
  }
}
