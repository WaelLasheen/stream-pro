import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class MoreMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool showEdit;

  const MoreMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.showEdit,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return AppPopupMenu<String>(
      menuWidth: 200.w,
      trigger: Icon(
        Icons.more_vert_rounded,
        size: 16.sp,
        color: appTheme.textSecondary,
      ),
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      items: [
        if (showEdit)
          AppMenuItem(
            value: 'edit',
            title: 'Edit',
            icon: Icons.edit_outlined,
            iconColor: appTheme.textSecondary,
          ),
        AppMenuItem(
          value: 'delete',
          title: 'Delete',
          icon: Icons.delete_outline_rounded,
          iconColor: appTheme.errorColor,
          titleColor: appTheme.errorColor,
        ),
      ],
    );
  }
}
