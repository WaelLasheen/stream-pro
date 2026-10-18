import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class WatchHistoryEmptyWidget extends StatelessWidget {
  const WatchHistoryEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = Theme.of(context).textTheme;

    return AppEmptyWidget(
      icon: Icons.history_toggle_off_rounded,
      iconSize: 64.r,
      iconColor: appTheme.grey500,
      message: 'No watch history found \nStart watching videos to build your history',
      messageStyle: textTheme.bodyLarge?.copyWith(
        color: appTheme.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
