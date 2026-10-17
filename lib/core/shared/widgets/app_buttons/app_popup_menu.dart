import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class AppMenuItem<T> {
  final T value;
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Color? titleColor;

  const AppMenuItem({
    required this.value,
    required this.title,
    this.icon,
    this.iconColor,
    this.titleColor,
  });
}

class AppPopupMenu<T> extends StatelessWidget {
  final Widget trigger;
  final Widget? header;
  final List<AppMenuItem<T>> items;
  final ValueChanged<T> onSelected;
  final double? menuWidth;

  const AppPopupMenu({
    super.key,
    required this.trigger,
    this.header,
    required this.items,
    required this.onSelected,
    this.menuWidth,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return PopupMenuButton<T>(
      padding: EdgeInsets.zero,
      iconSize: 16.sp,
      style: IconButton.styleFrom(
        minimumSize: Size(28.w, 28.h),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
      ),
      position: PopupMenuPosition.under,
      color: appTheme.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(color: appTheme.boarderPrimary, width: 1.w),
      ),
      constraints: menuWidth != null
          ? BoxConstraints(minWidth: menuWidth!)
          : null,
      onSelected: onSelected,
      itemBuilder: (context) => [
        if (header != null) PopupMenuItem<T>(enabled: false, child: header!),
        for (final item in items)
          PopupMenuItem<T>(
            value: item.value,
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 16.sp,
                    color: item.iconColor ?? appTheme.textSecondary,
                  ),
                  8.horizontalSpace,
                ],
                Flexible(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: item.titleColor ?? appTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
      child: trigger,
    );
  }
}
