import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'notification_item_shimmer.dart';

class NotificationLoadingView extends StatelessWidget {
  const NotificationLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerList(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      separator: 8.verticalSpace,
      itemCount: 6,
      itemBuilder: (_, _) => const NotificationItemShimmer(),
    );
  }
}
