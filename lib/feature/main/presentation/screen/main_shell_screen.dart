import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:stream_pro/feature/home/presentation/screen/home_screen.dart';
import 'package:stream_pro/feature/main/presentation/widgets/main_shell_app_bar.dart';
import 'package:stream_pro/feature/subscriptions/presentation/controllers/subscriptions_cubit/subscriptions_cubit.dart';
import 'package:stream_pro/feature/subscriptions/presentation/screens/subscriptions_screen.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_cubit.dart';
import 'package:stream_pro/feature/watch_history/presentation/screens/watch_history_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  final double _navBarHeight = 60.h;

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final ValueNotifier<bool> _isNavBarVisible = ValueNotifier(true);

  // Lazy tab cache
  final List<Widget?> _pages = List.filled(4, null);

  static const List<String> _selectedIcons = [
    ImagePath.homeActive,
    ImagePath.subscriptionsActive,
    ImagePath.upload,
    ImagePath.libraryActive,
  ];

  static const List<String> _unselectedIcons = [
    ImagePath.home,
    ImagePath.subscriptions,
    ImagePath.upload,
    ImagePath.library,
  ];

  @override
  void dispose() {
    _selectedIndex.dispose();
    _isNavBarVisible.dispose();
    super.dispose();
  }

  // ===========================================================================
  // LAZY PAGE BUILDER
  // ===========================================================================
  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        return BlocProvider(
          create: (_) => getIt<SubscriptionsCubit>()..fetchUserSubscriptions(),
          child: const SubscriptionsScreen(),
        );
      case 3:
        return BlocProvider(
          create: (_) => getIt<WatchHistoryCubit>()..fetchWatchHistory(),
          child: const WatchHistoryScreen(),
        );
      case 0:
      default:
        return BlocProvider(
          create: (_) => getIt<HomeCubit>()..fetchFeed(),
          child: const HomeScreen(),
        );
    }
  }

  // ===========================================================================
  // SCROLL LISTENER
  // ===========================================================================
  bool _handleScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      final pixels = notification.metrics.pixels;

      if (delta > 0 && pixels > 80) {
        _isNavBarVisible.value = false; // Scroll down -> hide
      } else if (delta < 0) {
        _isNavBarVisible.value = true; // Scroll up -> show
      }
    } else if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels <= 0) _isNavBarVisible.value = true;
    }
    return false;
  }

  // ===========================================================================
  // NAV BAR ITEMS
  // ===========================================================================
  List<Widget> _navItems(int selected) {
    return List.generate(
      _selectedIcons.length,
      (i) => SvgPicture.asset(
        i == selected ? _selectedIcons[i] : _unselectedIcons[i],
        width: 26.w,
        height: 26.h,
        colorFilter: ColorFilter.mode(
          i == selected
              ? context.appTheme.surfaceColor
              : context.appTheme.primaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (_selectedIndex.value == 0) {
          SystemNavigator.pop();
        } else {
          _selectedIndex.value = 0;
        }
      },
      child: Scaffold(
        extendBody: true,
        appBar: MainShellAppBar(),

        body: NotificationListener<ScrollNotification>(
          onNotification: _handleScroll,
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (context, index, _) {
              _pages[index] ??= _buildPage(index);

              return IndexedStack(
                index: index,
                children: _pages
                    .map((page) => page ?? const SizedBox.shrink())
                    .toList(),
              );
            },
          ),
        ),

        bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: _isNavBarVisible,
          builder: (context, visible, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: visible ? _navBarHeight + bottomInset : 0,
              child: visible
                  ? SafeArea(
                      top: false,
                      child: ValueListenableBuilder<int>(
                        valueListenable: _selectedIndex,
                        builder: (context, index, _) => CurvedNavigationBar(
                          index: index,
                          height: _navBarHeight,
                          color: context.appTheme.surfaceColor,
                          buttonBackgroundColor: context.appTheme.primaryColor,
                          backgroundColor: Colors.transparent,
                          animationDuration: const Duration(milliseconds: 300),
                          letIndexChange: (i) {
                            if (i == 2) {
                              context.navigateTo(AppRoutes.uploadVideo);
                              return false;
                            } else {
                              _selectedIndex.value = i;
                              return true;
                            }
                          },
                          items: _navItems(index),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
