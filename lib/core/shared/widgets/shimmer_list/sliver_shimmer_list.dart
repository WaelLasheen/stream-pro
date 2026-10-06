import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class SliverShimmerList extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final Color? baseColor;
  final Color? highlightColor;

  const SliverShimmerList({
    super.key,
    required this.itemBuilder,
    this.itemCount = 6,
    this.padding,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SliverPadding(
      padding: padding ?? EdgeInsets.all(12.r),
      sliver: SliverToBoxAdapter(
        child: Shimmer.fromColors(
          baseColor: baseColor ?? appTheme.grey500,
          highlightColor: highlightColor ?? appTheme.grey200,
          child: Column(
            children: List.generate(
              itemCount,
              (index) => itemBuilder(context, index),
            ),
          ),
        ),
      ),
    );
  }
}