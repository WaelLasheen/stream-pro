import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/mappers/playlist_video_mapper.dart';

class PlaylistVideoTile extends StatelessWidget {
  final PlaylistVideoEntity video;
  final bool isOwner;
  final int index;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const PlaylistVideoTile({
    super.key,
    required this.video,
    required this.isOwner,
    required this.index,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return VideoCardWidget(
      video: video.toVideoCardData(),
      onTap: onTap,
      showActions: false,
      trailing: _PlaylistVideoActions(
        isOwner: isOwner,
        index: index,
        onRemove: onRemove,
      ),
    );
  }
}

class _PlaylistVideoActions extends StatelessWidget {
  final bool isOwner;
  final int index;
  final VoidCallback? onRemove;

  const _PlaylistVideoActions({
    required this.isOwner,
    required this.index,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOwner) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReorderableDragStartListener(
          index: index,
          child: const _CircleAction(icon: Icons.drag_handle),
        ),
        6.verticalSpace,
        _CircleAction(icon: Icons.playlist_remove, onTap: onRemove),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleAction({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 28.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            shape: BoxShape.circle,
            border: Border.all(color: appTheme.grey600.withValues(alpha: 0.4)),
          ),
          child: Icon(icon, size: 15.r, color: Colors.white),
        ),
      ),
    );
  }
}
