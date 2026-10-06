import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppPadding on BuildContext {
  double get bottomNavPadding =>
      kBottomNavigationBarHeight + MediaQuery.paddingOf(this).bottom + 16.h;
}
