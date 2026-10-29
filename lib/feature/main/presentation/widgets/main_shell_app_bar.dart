import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/stream_pro_logo.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/main/presentation/widgets/profile_menu.dart';
import 'package:stream_pro/generated/l10n.dart';

class MainShellAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainShellAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppBar(
      centerTitle: false,
      titleSpacing: 4,
      title: Row(
        children: [
          StreamProLogo(size: 32.r),
          8.horizontalSpace,
          Text(
            S.current.streamPro,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, size: 24.r),
          onPressed: () => context.navigateTo(AppRoutes.search),
        ),
        IconButton(
          icon: Icon(Icons.notifications_active, size: 24.r),
          onPressed: () => context.navigateTo(AppRoutes.notifications),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const ProfileMenu(),
        ),
      ],
    );
  }
}
