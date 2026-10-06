import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerChannelTabBar extends StatelessWidget implements PreferredSizeWidget {
  const OwnerChannelTabBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(48.h);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: 'Videos'),
          Tab(text: 'Playlists'),
          Tab(text: 'Subscribers'),
        ],
      ),
    );
  }
}
