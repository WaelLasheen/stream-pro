import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/playlist/presentation/view_models/playlist_details_view.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_details_header.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_header_placeholder.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_header_shimmer.dart';

class PlaylistDetailsSliverAppBar extends StatelessWidget {
  final PlaylistDetailsView view;
  final bool isOwner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onBack;

  const PlaylistDetailsSliverAppBar({
    super.key,
    required this.view,
    required this.isOwner,
    required this.onEdit,
    required this.onDelete,
    required this.onBack,
  });

  Widget _buildHeader() {
    if (view.isLoading) return const PlaylistHeaderShimmer();

    final playlist = view.playlist;
    if (playlist == null) return const PlaylistHeaderPlaceholder();

    return PlaylistDetailsHeader(
      playlist: playlist,
      isOwner: isOwner,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      expandedHeight: 220.h,
      toolbarHeight: kToolbarHeight,
      backgroundColor: appTheme.backgroundColor,
      foregroundColor: appTheme.textPrimary,
      titleSpacing: 16.w,
      leading: _CollapsedBarPart(
        builder: (context, opacity) => IconButton(
          key: const Key('playlistAppBarBack'),
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      title: _CollapsedBarPart(
        builder: (context, opacity) => _PlaylistAppBarTitle(
          title: view.playlist?.title ?? '',
          opacity: opacity,
        ),
      ),
      actions: [
        if (isOwner)
          _CollapsedBarPart(
            builder: (context, opacity) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  key: const Key('playlistAppBarEdit'),
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: onEdit,
                ),
                IconButton(
                  key: const Key('playlistAppBarDelete'),
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _buildHeader(),
      ),
    );
  }
}

/// Renders its [builder] only while the app bar is collapsing.
///
/// The opacity matches the interval [FlexibleSpaceBar] uses to fade its
/// background, so the cover fades out at the same time as the toolbar content
/// fades in.
class _CollapsedBarPart extends StatelessWidget {
  final Widget Function(BuildContext context, double opacity) builder;

  const _CollapsedBarPart({required this.builder});

  @override
  Widget build(BuildContext context) {
    final opacity = _collapsedOpacityOf(context);
    if (opacity <= 0.01) return const SizedBox.shrink();
    return builder(context, opacity);
  }
}

/// Collapse progress of the app bar: `0` while the header is fully expanded,
/// `1` once it is collapsed.
double _collapsedOpacityOf(BuildContext context) {
  final settings = context
      .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
  if (settings == null) return 0;

  final deltaExtent = settings.maxExtent - settings.minExtent;
  if (deltaExtent <= 0) return 0;

  final progress = ((settings.maxExtent - settings.currentExtent) / deltaExtent)
      .clamp(0.0, 1.0);
  final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
  return Interval(fadeStart, 1.0).transform(progress);
}

/// The title of the playlist shown in the app bar once the header is
/// collapsed, so it is not displayed twice while the header is expanded.
class _PlaylistAppBarTitle extends StatelessWidget {
  final String title;
  final double opacity;

  const _PlaylistAppBarTitle({required this.title, required this.opacity});

  @override
  Widget build(BuildContext context) {
    if (title.isEmpty) return const SizedBox.shrink();

    return Opacity(
      opacity: opacity,
      child: Text(
        title,
        key: const Key('playlistAppBarTitle'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.appTheme.textPrimary,
        ),
      ),
    );
  }
}
