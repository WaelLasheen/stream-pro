import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ChannelTabBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(48.h);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: 'Home'),
          Tab(text: 'Videos'),
          Tab(text: 'Playlists'),
        ],
      ),
    );
  }
}
