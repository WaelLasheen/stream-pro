import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/generated/l10n.dart';

class OwnerChannelTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OwnerChannelTabBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(48.h);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: S.current.videos),
          Tab(text: S.current.playlists),
          Tab(text: S.current.subscribers),
        ],
      ),
    );
  }
}
