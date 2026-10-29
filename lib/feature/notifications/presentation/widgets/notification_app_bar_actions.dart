import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_popup_menu.dart';
import 'package:stream_pro/generated/l10n.dart';
import '../controllers/notifications_cubit/notifications_cubit.dart';

class NotificationAppBarActions extends StatelessWidget {
  const NotificationAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<String>(
      trigger: Icon(Icons.more_vert, size: 24.r),
      onSelected: (value) {
        final cubit = context.read<NotificationsCubit>();
        switch (value) {
          case 'mark_all':
            cubit.markAllAsRead();
            break;
          case 'clear_all':
            cubit.deleteAll();
            break;
        }
      },
      items:  [
        AppMenuItem(
          value: 'mark_all',
          title: S.current.markAllAsRead,
          icon: Icons.done_all,
        ),
        AppMenuItem(
          value: 'clear_all',
          title: S.current.clearAllNotifications,
          icon: Icons.delete_outline,
        ),
      ],
    );
  }
}
