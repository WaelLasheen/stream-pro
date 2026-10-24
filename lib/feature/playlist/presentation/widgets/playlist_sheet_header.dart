import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/drag_handle_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class PlaylistSheetHeader extends StatelessWidget {
  final String title;
  final double topSpacing;
  final double titleSpacing;

  const PlaylistSheetHeader({
    super.key,
    required this.title,
    this.topSpacing = 12,
    this.titleSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        topSpacing.verticalSpace,
        const DragHandleWidget(),
        titleSpacing.verticalSpace,
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: appTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
