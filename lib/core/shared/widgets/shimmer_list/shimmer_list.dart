import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class ShimmerList extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Color? baseColor;
  final Color? highlightColor;
  final Axis scrollDirection;

  const ShimmerList({
    super.key,
    required this.itemBuilder,
    this.itemCount = 6,
    this.padding,
    this.separator,
    this.physics,
    this.shrinkWrap = false,
    this.baseColor,
    this.highlightColor,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Shimmer.fromColors(
      baseColor: baseColor ?? appTheme.grey500,
      highlightColor: highlightColor ?? appTheme.grey200,
      child: ListView.separated(
        padding: padding ?? EdgeInsets.all(16.r),
        physics: physics,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        separatorBuilder: (_, __) => separator ?? 12.verticalSpace,
      ),
    );
  }
}
