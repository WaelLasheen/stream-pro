import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/generated/l10n.dart';

class ChannelTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ChannelTabBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(48.h);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: S.current.home),
          Tab(text: S.current.videos),
          Tab(text: S.current.playlists),
        ],
      ),
    );
  }
}
